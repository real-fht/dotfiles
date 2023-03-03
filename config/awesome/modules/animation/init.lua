---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'modules.animation'
---From scratch animation module/service, inspired by KwesomeDE's one
---------------------------------------------------------------------------------

local GLib = require("lgi").GLib
local gobject = require "gears.object"
local gtable = require "gears.table"
local subscribable = require "modules.animation.subscribable"
local tween = require "modules.animation.tween"

local animation, manager, instance = {}, {}, nil
manager.easing = tween.easing

-- Set this to (1000/screen refresh rate), this is the animations refresh
-- delta, I guess.
local ANIMATION_FRAME_DELAY = 16.7

function animation:start(args)
    -- stylua: ignore start
    args           = args or {}
    -- -*- Awestore/Rubato compatibility
    local is_table = type(args) == 'table'
    local initial  = is_table and (args.pos or self.pos) or self.pos
    local subject  = is_table and (args.subject or self.subject) or self.subject
    local target   = is_table and (args.target or self.target) or args
    local duration = is_table and (args.duration or self.duration) or self.duration
    local easing   = is_table and (args.easing or self.easing) or self.easing
    duration       = self._private.anim_manager._private.instant == true and 0.01 or duration
  -- stylua: ignore end

  if self.tween == nil or self.reset_on_stop == true then
    self.tween = tween.new {
      initial = initial,
      subject = subject,
      target = target,
      duration = duration * 10 ^ 6,
      easing = easing,
    }
  end

  if self._private.anim_manager._private.animations[self.index] == nil then
    table.insert(self._private.anim_manager._private.animations, self)
  end

  self.state = true
  self.last_elapsed = GLib.get_monotonic_time()
  self:emit_signal "started"
end

function animation:set(args)
  self:start(args)
  self:emit_signal "set"
end

function animation:stop()
  self.state = false
  self:emit_signal "stopped"
end

function animation:abort()
  animation:stop()
  self:emit_signal "aborted"
end

function animation:initial()
  return self._private.initial
end

function manager:set_instant(value)
  self._private.instant = value
end

function manager:new(args)
    -- stylua: ignore start
    args               = args or {}
    args.pos           = args.pos or 0
    args.subject       = args.subject or nil
    args.target        = args.target or nil
    args.duration      = args.duration or 0
    args.easing        = args.easing or nil
    args.loop          = args.loop or false
    args.update        = args.update or nil
    args.reset_on_stop = args.reset_on_stop == nil and true or args.reset_on_stop
  -- stylua: ignore end

  -- Awestore/Rubato compatibility
  local new_anim = subscribable()
  -- new_anim.started, new_anim.ended = subscribable(), subscribable()

  if args.update ~= nil then
    new_anim:connect_signal("update", args.update)
  end

  gtable.crush(new_anim, args, true)
  gtable.crush(new_anim, animation, true)

  new_anim._private = {}
  new_anim._private.anim_manager = self
  new_anim._private.initial = args.pos

  return new_anim
end

local function new()
  local obj = gobject {}
  gtable.crush(obj, manager, true)
  obj._private = { animations = {}, instant = false }

  GLib.timeout_add(GLib.PRIORITY_DEFAULT, ANIMATION_FRAME_DELAY, function()
    for index, anim in ipairs(obj._private.animations) do
      if anim.state == true then
        -- compute delta time
        local time = GLib.get_monotonic_time()
        local delta = time - anim.last_elapsed
        anim.last_elapsed = time

        -- If pos is true, the animation has ended
        local pos = anim.tween:update(delta)
        if pos == true then
          if anim.loop == true then
            -- Loop the animation, useful for loading widgets.
            anim.tween:reset()
          else
            -- Otherwise snap to the end, and disable the animation
            anim.pos = anim.tween.target
            anim:fire(anim.pos)
            anim:emit_signal("update", anim.pos)
            -- -*- Disable and remove the animation
            anim.state = false
            -- animation.ended:fire(pos)
            table.remove(obj._private.animations, index)
            anim:emit_signal("ended", anim.pos)
          end
        else
          -- Otherwise, keep updating
          anim.pos = pos
          anim:fire(anim.pos)
          anim:emit_signal("update", anim.pos)
        end
      else
        -- If an animation state is false, means it ended
        table.remove(obj._private.animations, index)
      end
    end
    -- Return true to call the function again
    return true
  end)

  return obj
end

instance = instance or new()
return instance
