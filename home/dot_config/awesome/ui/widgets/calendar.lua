---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.calendar'
---------------------------------------------------------------------------------

local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gobject = require("gears.object")
local gtable = require("gears.table")
local helpers = require("helpers")
local wibox = require("wibox")
local wtbutton = require("ui.widgets.button.text")
local wtext = require("ui.widgets.text")

local calendar = { mt = {} }

local function day_name_widget(name)
  return wibox.widget({
    widget = wibox.container.background,
    forced_width = dpi(30),
    forced_height = dpi(30),
    wtext({
      halign = "center",
      size = 12,
      bold = true,
      text = name,
    }),
  })
end

local function date_widget(date, is_current, is_another_month)
  local text_color = beautiful.colors.white

  if is_current == true then
    text_color = beautiful.accent
  elseif is_another_month == true then
    text_color = beautiful.colors.grey
  end

  return wibox.widget({
    widget = wibox.container.background,
    forced_width = dpi(30),
    forced_height = dpi(30),
    shape = helpers.ui.rounded_rect(),
    bg = is_current and beautiful.colors.oneb3 or beautiful.colors.transparent,
    wtext({
      halign = "center",
      size = 12,
      color = text_color,
      text = tostring(date),
    }),
  })
end

function calendar:set_date(date)
  self.date = date

  self.days:reset()

  local current_date = os.date("*t")

  self.days:add(day_name_widget("Su"))
  self.days:add(day_name_widget("Mo"))
  self.days:add(day_name_widget("Tu"))
  self.days:add(day_name_widget("We"))
  self.days:add(day_name_widget("Th"))
  self.days:add(day_name_widget("Fr"))
  self.days:add(day_name_widget("Sa"))

  local first_day = os.date("*t", os.time({ year = date.year, month = date.month, day = 1 }))
  local last_day = os.date("*t", os.time({ year = date.year, month = date.month + 1, day = 0 }))
  local month_days = last_day.day

  local time = os.time({ year = date.year, month = date.month, day = 1 })
  self.month:set_text(os.date("%B %Y", time))

  local days_to_add_at_month_start = first_day.wday - 1
  local days_to_add_at_month_end = 42 - last_day.day - days_to_add_at_month_start

  local previous_month_last_day = os.date("*t", os.time({ year = date.year, month = date.month, day = 0 })).day
  for day = previous_month_last_day - days_to_add_at_month_start, previous_month_last_day - 1, 1 do
    self.days:add(date_widget(day, false, true))
  end

  for day = 1, month_days do
    local is_current = day == current_date.day and date.month == current_date.month
    self.days:add(date_widget(tostring(day), is_current, false))
  end

  for day = 1, days_to_add_at_month_end do
    self.days:add(date_widget(day, false, true))
  end
end

function calendar:set_date_current()
  self:set_date(os.date("*t"))
end

function calendar:increase_date()
  local new_calendar_month = self.date.month + 1
  self:set_date({ year = self.date.year, month = new_calendar_month, day = self.date.day })
end

function calendar:decrease_date()
  local new_calendar_month = self.date.month - 1
  self:set_date({ year = self.date.year, month = new_calendar_month, day = self.date.day })
end

local function new()
  local ret = gobject({})
  gtable.crush(ret, calendar, true)

  ret.month = wtbutton.normal({
    animate_size = false,
    normal_bg = beautiful.colors.transparent,
    forced_height = dpi(30),
    paddings = { left = dpi(12), right = dpi(12) },
    text = os.date("%B %Y"),
    on_release = function()
      ret:set_date_current()
    end,
  })

  local month = wibox.widget({
    layout = wibox.layout.align.horizontal,
    wtbutton.normal({
      forced_width = dpi(30),
      forced_height = dpi(30),
      font = beautiful.icons.caret_left.font,
      size = 12,
      halign = "center",
      normal_fg = beautiful.colors.grey,
      normal_bg = beautiful.colors.transparent,
      text = beautiful.icons.caret_left.icon,
      on_release = function()
        ret:decrease_date()
      end,
    }),
    ret.month,
    wtbutton.normal({
      forced_width = dpi(30),
      forced_height = dpi(30),
      font = beautiful.icons.caret_right.font,
      size = 12,
      halign = "center",
      normal_fg = beautiful.colors.grey,
      normal_bg = beautiful.colors.transparent,
      text = beautiful.icons.caret_right.icon,
      on_release = function()
        ret:increase_date()
      end,
    }),
  })

  ret.days = wibox.widget({
    layout = wibox.layout.grid,
    forced_num_rows = 6,
    forced_num_cols = 7,
    spacing = dpi(8),
    expand = true,
  })

  local widget = wibox.widget({
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(12),
    month,
    require("ui.widgets.separator")({
      orientation = "vertical",
      thickness = dpi(2),
      forced_height = dpi(2),
    }),
    ret.days,
  })

  ret:set_date(os.date("*t"))

  gtable.crush(widget, calendar, true)
  return widget
end

function calendar.mt:__call()
  return new()
end

return setmetatable(calendar, calendar.mt)
