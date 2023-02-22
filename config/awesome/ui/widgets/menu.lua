---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.menu'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gshape = require("gears.shape")
local gtable = require("gears.table")
local gtimer = require("gears.timer")
local wcontainer = require("ui.widgets.container")
local twidget = require("ui.widgets.text")
local bwidget = require("ui.widgets.button")
local helpers = require("helpers")
local wibox = require("wibox")

local menu = { mt = {} }

---@class menu_set_pos_args
---@field coords table
---@field wibox any
---@field widget any
---@field offset {x:number, y:number}

---@param args menu_set_pos_args
function menu:set_pos(args)
  args = args or {}
  -- -*- Args setup.
  local coords = args.coords
  local wibox = args.wibox
  local widget = args.widget
  local offset = args.offset or { x = 0, y = 0 }
  offset.x = offset.x or 0
  offset.y = offset.y or 0

  local screen_workarea = awful.screen.focused().workarea
  local screen_w = screen_workarea.x + screen_workarea.width
  local screen_h = screen_workarea.y + screen_workarea.height

  if not coords and wibox and widget then
    -- Use the given wibox/widget coords if given.
    coords = helpers.ui.get_widget_geometry(wibox, widget)
  else
    -- Use the given coords else put it next to the cursor.
    coords = args.coords or mouse.coords()
  end

  if coords.x + self.width > screen_w then
    if self.parent_menu ~= nil then
      self.x = coords.x - (self.width * 2) - offset.x
    else
      self.x = coords.x - self.width + offset.x
    end
  else
    self.x = coords.x + offset.x
  end

  if coords.y + self.height > screen_h then
    self.y = screen_h - self.height + offset.y
  else
    self.y = coords.y + offset.y
  end
end

function menu:hide_parents_menus()
  if self.parent_menu ~= nil then
    self.parent_menu:hide(true)
  end
end

function menu:hide_children_menus()
  for _, button in ipairs(self.widget.children) do
    if button.sub_menu ~= nil then
      button.sub_menu:hide()
      button:turn_off()
    end
  end
end

function menu:hide(hide_parents)
  if self.visible == false then
    return
  end

  -- Hide self
  self.visible = false

  -- Hides all child menus
  self:hide_children_menus()

  if hide_parents == true then
    self:hide_parents_menus()
  end
end

function menu:show(args)
  if self.visible == true then
    return
  end

  self.can_hide = false

  gtimer({
    timeout = 0.1,
    autostart = true,
    call_now = false,
    single_shot = true,
    callback = function()
      self.can_hide = true
    end,
  })

  -- Hide sub menus belonging to the menu of self
  if self.parent_menu ~= nil then
    for _, button in ipairs(self.parent_menu.widget.children) do
      if button.sub_menu ~= nil and button.sub_menu ~= self then
        button.sub_menu:hide()
        button:turn_off()
      end
    end
  end

  self:set_pos(args)
  self.visible = true

  awesome.emit_signal("menu::toggled_on", self)
end

function menu:toggle(args)
  if self.visible == true then
    self:hide()
  else
    self:show(args)
  end
end

function menu:add(widget)
  if widget.sub_menu then
    widget.sub_menu.parent_menu = self
  end
  widget.menu = self
  self.widget:add(widget)
end

function menu:remove(widget)
  self.widget:remove(widget)
end

function menu:reset()
  -- Removes all the menu entries.
  self.widget:reset()
end

function menu.menu(widgets, width)
  local widget = awful.popup({
    x = 32500,
    type = "menu",
    visible = false,
    ontop = true,
    minimum_width = width or dpi(300),
    maximum_width = width or dpi(300),
    shape = gshape.rectangle,
    bg = beautiful.menu_bg,
    widget = wibox.widget({
      layout = wibox.layout.fixed.vertical,
      spacing = beautiful.menu_button_spacing,
    }),
  })
  gtable.crush(widget, menu, true)

  -- Hide the menu when clicking on different clients
  awful.mouse.append_client_mousebinding(awful.button({ "Any" }, 1, function()
    if widget.can_hide == true then
      widget:hide(true)
    end
  end))
  -- -*-
  awful.mouse.append_client_mousebinding(awful.button({ "Any" }, 3, function()
    if widget.can_hide == true then
      widget:hide(true)
    end
  end))
  -- And hide the menu when clicking on the root window
  awful.mouse.append_global_mousebinding(awful.button({ "Any" }, 1, function()
    if widget.can_hide == true then
      widget:hide(true)
    end
  end))
  -- -*-
  awful.mouse.append_global_mousebinding(awful.button({ "Any" }, 3, function()
    if widget.can_hide == true then
      widget:hide(true)
    end
  end))
  -- Also hide the menu when changing tags
  tag.connect_signal("property::selected", function()
    widget:hide(true)
  end)

  -- Hide all other opened menus when opening a new menu.
  awesome.connect_signal("menu::toggled_on", function(m)
    if m ~= widget and m.parent_menu == nil then
      widget:hide(true)
    end
  end)

  -- Initiate our menu widgets.
  widget:add(helpers.ui.vertical_padding(beautiful.menu_paddings))
  for _, menu_widget in ipairs(widgets) do
    widget:add(menu_widget)
  end
  widget:add(helpers.ui.vertical_padding(beautiful.menu_paddings))

  return widget
end

---@class menu_button_args
---@field icon {icon:string, font:string}?
---@field icon_size number?
---@field icon_color string?
---@field image string?
---@field text string?
---@field text_size number?
---@field on_press function?

---@param args menu_button_args
function menu.button(args)
  args = args or {}
  -- -*- Args setup.
  args.icon = args.icon or nil
  args.icon_size = args.icon_size or 12
  args.icon_color = args.icon_color or beautiful.accent
  -- args.image = args.image
  args.text = args.text or ""
  args.text_size = args.text_size or 12
  args.on_press = args.on_press or nil

  local icon = nil

  if args.icon ~= nil then
    -- If there's a text icon, use it
    icon = wcontainer({
      forced_height = args.icon_size * 2,
      forced_width = args.icon_size * 2,
      bg = beautiful.colors.transparent,
      child = twidget({
        font = args.icon.font,
        halign = "center",
        size = args.icon_size,
        color = args.icon_color,
        text = args.icon.icon,
      }),
    })
  elseif args.image ~= nil then
    -- Otherwise if there's an image, use it instead.
    icon = wibox.widget({
      widget = wibox.widget.imagebox,
      image = args.image,
    })
  end

  local text_widget = twidget({
    size = args.text_size,
    text = args.text,
  })

  return bwidget.basic.normal({
    forced_height = beautiful.menu_button_size,
    forced_width = dpi(300),
    normal_bg = beautiful.colors.transparent,
    hover_bg = beautiful.menu_button_hover_bg,
    press_bg = beautiful.menu_button_press_bg,
    paddings = beautiful.menu_button_paddings,
    margins = {
      left = beautiful.menu_paddings,
      right = beautiful.menu_paddings,
    },
    -- margins = dpi(2),
    halign = "left",
    shape = helpers.ui.rounded_rect(),
    on_release = function(self)
      self.menu:hide(true)
      args.on_press(self, text_widget)
    end,
    on_hover = function(self)
      self.menu:hide_children_menus()
    end,
    child = {
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(6),
      icon,
      text_widget,
    },
  })
end

---@param args menu_button_args
function menu.sub_menu_button(args)
  args = args or {}

  args.icon = args.icon or nil
  args.icon_size = args.icon_size or 12
  args.text = args.text or ""
  args.text_size = args.text_size or 12
  args.sub_menu = args.sub_menu or nil

  local icon = args.icon ~= nil
      and wcontainer({
        forced_height = args.icon_size * 2,
        forced_width = args.icon_size * 2,
        bg = beautiful.colors.transparent,
        child = twidget({
          font = args.icon.font,
          halign = "center",
          size = args.icon_size,
          color = beautiful.secondary_accent,
          text = args.icon.icon,
        }),
      })
    or nil

  local widget = bwidget.basic.state({
    forced_height = beautiful.menu_button_size,
    forced_width = dpi(300),
    normal_bg = beautiful.colors.transparent,
    hover_bg = beautiful.menu_button_hover_bg,
    press_bg = beautiful.menu_button_press_bg,
    paddings = beautiful.menu_button_paddings,
    margins = {
      left = beautiful.menu_paddings,
      right = beautiful.menu_paddings,
    },
    -- margins = dpi(2),
    halign = "left",
    shape = helpers.ui.rounded_rect(),
    on_hover = function(self)
      local coords = helpers.ui.get_widget_geometry(self.menu, self)
      coords.x = coords.x + self.menu.x + self.menu.width
      coords.y = coords.y + self.menu.y
      args.sub_menu:show({ coords = coords, offset = { x = -5 } })
      self:turn_on()
    end,
    child = {
      layout = wibox.layout.align.horizontal,
      forced_width = dpi(300),
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(6),
        icon,
        twidget({ size = args.text_size, text = args.text }),
      },
      nil,
      twidget({
        font = beautiful.icons.chevron_right.font,
        text = beautiful.icons.chevron_right.icon,
        color = beautiful.menu_button_submenu_caret_color,
        size = 12,
      }),
    },
  })

  widget.sub_menu = args.sub_menu

  return widget
end

function menu.separator()
  return wibox.widget({
    widget = wibox.container.margin,
    margins = beautiful.menu_paddings,
    {
      widget = wibox.widget.separator,
      forced_height = dpi(2),
      orientation = "horizontal",
      thickness = dpi(2),
      color = beautiful.colors.onebg,
    },
  })
end

---@class menu_checkbox_button_args:menu_button_args
---@field checkbox_color string?
---@field on_by_default boolean?

function menu.checkbox_button(args)
  args = args or {}

  args.icon = args.icon or nil
  args.icon_size = args.icon_size or 12
  args.icon_color = args.icon_color or beautiful.accent
  -- args.image = args.image
  args.text = args.text or ""
  args.text_size = args.text_size or 12
  args.checkbox_color = args.checkbox_color or beautiful.accent
  args.on_by_default = args.on_by_default or nil
  args.on_press = args.on_press or nil

  local icon = nil

  if args.icon ~= nil then
    -- If there's a text icon, use it
    icon = wcontainer({
      forced_height = args.icon_size * 2,
      forced_width = args.icon_size * 2,
      bg = beautiful.colors.transparent,
      child = twidget({
        font = args.icon.font,
        halign = "center",
        size = args.icon_size,
        color = args.icon_color,
        text = args.icon.icon,
      }),
    })
  elseif args.image ~= nil then
    -- Otherwise if there's an image, use it instead.
    icon = wibox.widget({
      widget = wibox.widget.imagebox,
      image = args.image,
    })
  end

  local checkbox = twidget({
    size = dpi(12),
    color = args.checkbox_color,
    font = beautiful.icons.toggle_on,
    halign = "right",
    text = args.on_by_default == true and beautiful.icons.toggle_on.icon or beautiful.icons.toggle_off.icon,
  })

  local widget = bwidget.basic.state({
    forced_height = beautiful.menu_button_size,
    forced_width = dpi(300),
    normal_bg = beautiful.colors.transparent,
    hover_bg = beautiful.menu_button_hover_bg,
    press_bg = beautiful.menu_button_press_bg,
    on_normal_bg = beautiful.colors.transparent,
    on_hover_bg = beautiful.menu_button_hover_bg,
    on_press_bg = beautiful.menu_button_press_bg,
    paddings = beautiful.menu_button_paddings,
    margins = {
      left = beautiful.menu_paddings,
      right = beautiful.menu_paddings,
    },
    on_release = function(self)
      self.menu:hide(true)
      if args.on_press then
        args.on_press()
      end
    end,
    on_hover = function(self)
      self.menu:hide_children_menus()
    end,
    child = {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(6),
        icon,
        twidget({ size = args.text_size, text = args.text }),
      },
      nil,
      checkbox,
    },
    on_turn_on = function()
      checkbox:set_text(beautiful.icons.toggle_on.icon)
    end,
    on_turn_off = function()
      checkbox:set_text(beautiful.icons.toggle_off.icon)
    end,
  })

  return widget
end

return menu
