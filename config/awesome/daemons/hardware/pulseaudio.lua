---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'daemons.hardware.pulseaudio'
---------------------------------------------------------------------------------

local awful = require("awful")
local gobject = require("gears.object")
local gtable = require("gears.table")
local gtimer = require("gears.timer")

local pulseaudio, instance = {}, nil

function pulseaudio:set_default_sink(sink)
  awful.spawn(string.format("pactl set-default-sink %d", sink), false)
end

function pulseaudio:sink_toggle_mute(sink)
  sink = (sink == 0 or sink == nil) and "@DEFAULT_SINK@" or sink
  awful.spawn(string.format("pactl set-sink-mute %s toggle", sink), false)
end

function pulseaudio:sink_volume_up(sink, step)
  sink = (sink == 0 or sink == nil) and "@DEFAULT_SINK@" or sink
  awful.spawn(string.format("pactl set-sink-volume %s +%d%%", sink, step), false)
end

function pulseaudio:sink_volume_down(sink, step)
  sink = (sink == 0 or sink == nil) and "@DEFAULT_SINK@" or sink
  awful.spawn(string.format("pactl set-sink-volume %s -%d%%", sink, step), false)
end

function pulseaudio:sink_set_volume(sink, volume)
  sink = (sink == 0 or sink == nil) and "@DEFAULT_SINK@" or sink
  awful.spawn(string.format("pactl set-sink-volume %s %d%%", sink, volume), false)
end

function pulseaudio:set_default_source(source)
  awful.spawn(string.format("pactl set-default-source %d", source), false)
end

function pulseaudio:source_toggle_mute(source)
  source = (source == 0 or source == nil) and "@DEFAULT_SOURCE@" or source
  awful.spawn(string.format("pactl set-source-mute %s toggle", source), false)
end

function pulseaudio:source_volume_up(source, step)
  source = (source == 0 or source == nil) and "@DEFAULT_SOURCE@" or source
  awful.spawn(string.format("pactl set-source-volume %s +%d%%", source, step), false)
end

function pulseaudio:source_volume_down(source, step)
  source = (source == 0 or source == nil) and "@DEFAULT_SOURCE@" or source
  awful.spawn(string.format("pactl set-source-volume %s -%d%%", source, step), false)
end

function pulseaudio:source_set_volume(source, volume)
  source = (source == 0 or source == nil) and "@DEFAULT_SOURCE@" or source
  awful.spawn(string.format("pactl set-source-volume %s %d%%", source, volume), false)
end

function pulseaudio:sink_input_toggle_mute(sink_input)
  awful.spawn(string.format("pactl set-sink-input-mute %d toggle", sink_input), false)
end

function pulseaudio:sink_input_set_volume(sink_input, volume)
  awful.spawn(string.format("pactl set-sink-input-volume %d %d%%", sink_input, volume), false)
end

function pulseaudio:source_output_toggle_mute(source_output)
  awful.spawn(string.format("pactl set-source-output-mute %d toggle", source_output), false)
end

function pulseaudio:source_output_set_volume(source_output, volume)
  awful.spawn(string.format("pactl set-source-output-volume %d %d%%", source_output, volume), false)
end

function pulseaudio:get_sinks()
  return self._private.sinks
end

function pulseaudio:get_sources()
  return self._private.sources
end

---Marks the default device for each type.
---@param self table
local function on_default_device_changed(self)
  awful.spawn.easy_async_with_shell([[pactl info | grep "Default Sink:\|Default Source:"]], function(stdout)
    -- Match for each new line
    for line in stdout:gmatch("[^\r\n]+") do
      -- Try to get the default device name from stdout
      local default_device_name = line:match(": (.*)")
      -- the default device's type too
      local default_device_type = line:match("Default Sink") and "sinks" or "sources"
      for _, device in pairs(self._private[default_device_type]) do
        if device.name == default_device_name then
          if device.default == false then
            device.default = true
            self:emit_signal(string.format("%s::updated_default", default_device_type), device)
          end
        else
          device.default = false
        end
        self:emit_signal(string.format("%s::%s::updated", default_device_type, device.id), device)
      end
    end
  end)
end

---Scans for devices using pactl output.
---@param self table
local function get_devices(self)
  awful.spawn.easy_async_with_shell(
    [[
    pactl list sinks | grep "Sink #\|Name:\|Description:\|Mute:\|Volume: ";
    pactl list sources | grep "Source #\|Name:\|Description:\|Mute:\|Volume:"
    ]],
    function(stdout)
      local device = {}
      -- Match for each new line.
      for line in stdout:gmatch("[^\r\n]+") do
        if line:match("Sink") or line:match("Source") then
          device = {
            id = line:match("#(%d+)"),
            type = line:match("Sink") and "sinks" or "sources",
            default = false,
          }
        elseif line:match("Name") then
          device.name = line:match(": (.*)")
        elseif line:match("Description") then
          device.description = line:match(": (.*)")
        elseif line:match("Mute") then
          device.mute = line:match(": (.*)") == "yes" and true or false
        elseif line:match("Volume") then
          device.volume = tonumber(line:match("(%d+)%%"))

          if self._private[device.type][device.id] == nil then
            self:emit_signal(device.type .. "::added", device)
          end
          self._private[device.type][device.id] = device
        end
      end

      -- After scanning and adding all devices, search for the default one android
      -- mark it with the default property.
      on_default_device_changed(self)
    end
  )
end

---Scan for applications from pactl output
---@param self table
local function get_applications(self)
  awful.spawn.easy_async_with_shell(
    [[
    pactl list sink-inputs | grep "Sink Input #\|application.name = \|application.icon_name = \|Mute:\|Volume: ";
    pactl list source-outputs | grep "Source Input #\|application.name = \|application.icon_name = \|Mute:\|Volume: "
    ]],
    function(stdout)
      local application = {}
      for line in stdout:gmatch("[^\r\n]+") do
        if line:match("Sink Input") or line:match("Source Output") then
          application = {
            id = line:match("#(%d+)"),
            type = line:match("Sink Input") and "sink_inputs" or "source_outputs",
          }
        elseif line:match("Mute") then
          application.mute = line:match(": (.*)") == "yes" and true or false
        elseif line:match("Volume") then
          application.volume = tonumber(line:match("(%d+)%%"))
        elseif line:match("application.name") then
          application.name = line:match(" = (.*)"):gsub('"', "")

          -- Check if the app already existed in the audio apps list, otherwise, add it.
          local old_application_copy = self._private[application.type][application.id]
          if old_application_copy == nil then
            self:emit_signal(application.type .. "::added", application)
          elseif
            -- Check if volume or mute status changed, to emit update signal
            (application.volume ~= old_application_copy.volume)
            or (application.mute ~= old_application_copy.mute)
          then
            self:emit_signal(application.type .. "::" .. application.id .. "::updated", application)
          end

          -- Update the application type
          self._private[application.type][application.id] = application
        elseif line:match("application.icon_name") then
          application.icon_name = line:match(" = (.*)"):gsub('"', "")
          self:emit_signal(application.type .. "::" .. application.id .. "::icon_name", application.icon_name)
        end
      end
    end
  )
end

local function on_device_updated(self, type, id)
  if self._private[type][id] == nil then
    get_devices(self)
    return
  end

  local type_no_s = type:sub(1, -2)

  awful.spawn.easy_async_with_shell(
    string.format("pactl get-%s-volume %s; pactl get-%s-mute %s", type_no_s, id, type_no_s, id),
    function(stdout)
      local was_there_any_change = false

      for line in stdout:gmatch("[^\r\n]+") do
        if line:match("Volume") then
          local volume = tonumber(line:match("(%d+)%%"))
          if volume ~= self._private[type][id].volume then
            was_there_any_change = true
          end
          self._private[type][id].volume = volume
        elseif line:match("Mute") then
          local mute = line:match(": (.*)") == "yes" and true or false
          if mute ~= self._private[type][id].mute then
            was_there_any_change = true
          end
          self._private[type][id].mute = mute
        end
      end

      if was_there_any_change == true then
        self:emit_signal(type .. "::" .. id .. "::updated", self._private[type][id])
        if self._private[type][id].default == true then
          self:emit_signal(string.format("%s::default::updated", type), self._private[type][id])
        end
      end
    end
  )
end

local function on_object_removed(self, type, id)
  self._private[type][id] = nil
  self:emit_signal(type .. "::" .. id .. "::removed")
end

local function new()
  local ret = gobject({})
  gtable.crush(ret, pulseaudio, true)

  -- Fields for stored data about audio devices and programs
  ret._private = {}
  ret._private.sinks = {}
  ret._private.sources = {}
  ret._private.sink_inputs = {}
  ret._private.source_outputs = {}

  -- Initiate pulseaudio event subscribing 5 seconds after awesomewm starts
  -- to wait for pulseaudio (managed by pipewire) initiate
  gtimer({
    timeout = 5,
    autostart = true,
    call_now = false,
    single_shot = true,
    callback = function()
      get_devices(ret)
      get_applications(ret)

      -- Kill stale pactl processes
      awful.spawn.easy_async("pkill -f 'pactl subscribe'", function()
        awful.spawn.with_line_callback("pactl subscribe", {
          stdout = function(line)
            ---------------------------------------------------------------------------------------------------------
            -- Devices
            ---------------------------------------------------------------------------------------------------------
            if line:match("Event 'new' on sink #") or line:match("Event 'new' on source #") then
              get_devices(ret)
            elseif line:match("Event 'change' on server") then
              on_default_device_changed(ret)
            elseif line:match("Event 'change' on sink #") then
              local id = line:match("Event 'change' on sink #(.*)")
              on_device_updated(ret, "sinks", id)
            elseif line:match("Event 'change' on source #") then
              local id = line:match("Event 'change' on source #(.*)")
              on_device_updated(ret, "sources", id)
            elseif line:match("Event 'remove' on sink #") then
              local id = line:match("Event 'remove' on sink #(.*)")
              on_object_removed(ret, "sinks", id)
            elseif line:match("Event 'remove' on source #") then
              local id = line:match("Event 'remove' on source #(.*)")
              on_object_removed(ret, "sources", id)
              ---------------------------------------------------------------------------------------------------------
              -- Applications
              ---------------------------------------------------------------------------------------------------------
            elseif line:match("Event 'new' on sink%-input #") or line:match("Event 'new' on source%-input #") then
              get_applications(ret)
            elseif line:match("Event 'change' on sink%-input #") then
              get_applications(ret)
            elseif line:match("Event 'change' on source%-output #") then
              get_applications(ret)
            elseif line:match("Event 'remove' on sink%-input #") then
              local id = line:match("Event 'remove' on sink%-input #(.*)")
              on_object_removed(ret, "sink_inputs", id)
            elseif line:match("Event 'remove' on source%-output #") then
              local id = line:match("Event 'remove' on source%-output #(.*)")
              on_object_removed(ret, "source_outputs", id)
            end
          end,
        })
      end)
    end,
  })

  return ret
end

instance = instance or new()
return instance
