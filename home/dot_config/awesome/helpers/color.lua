---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'helpers.color'
---------------------------------------------------------------------------------

local M = {}

--@usage Returns a value that is clipped to interval edges if it falls outside the interval
function M.clip(num, min_num, max_num)
  return math.max(math.min(num, max_num), min_num)
end

--@usage Convert a r,g,b tuple to hex code string
--@param r,g,b,a number
-- Converts the given hex color to rgba
function M.rgba_to_hex(color)
  local r = M.clip(color.r or color[1], 0, 255)
  local g = M.clip(color.g or color[2], 0, 255)
  local b = M.clip(color.b or color[3], 0, 255)
  local a = M.clip(color.a or color[4] or 255, 0, 255)
  local _color = "#" .. string.format("%02x%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b), math.floor(a))
  return _color
end

--@usage Convert #RRGGBB(AA) hex string into rgb values.
--@param hex string
--@returns (r,g,b,a)
function M.hex_to_rgba(color)
  color = color:gsub("#", "")
  local tbl = {
    r = tonumber("0x" .. color:sub(1, 2)),
    g = tonumber("0x" .. color:sub(3, 4)),
    b = tonumber("0x" .. color:sub(5, 6)),
    a = #color == 8 and tonumber("0x" .. color:sub(7, 8)) or 255,
  }

  return tbl
end

--- Lighten a color.
--
-- @string color The color to lighten with hexadecimal HTML format `"#RRGGBB"`.
-- @int[opt=26] amount How much light from 0 to 255. Default is around 10%.
-- @treturn string The lighter color
function M.lighten(color, amount)
  -- require 'naughty.notification' { text = color }
  amount = amount or 26
  local c = {
    r = tonumber("0x" .. color:sub(2, 3)),
    g = tonumber("0x" .. color:sub(4, 5)),
    b = tonumber("0x" .. color:sub(6, 7)),
  }

  c.r = c.r + amount
  c.r = c.r < 0 and 0 or c.r
  c.r = c.r > 255 and 255 or c.r
  c.g = c.g + amount
  c.g = c.g < 0 and 0 or c.g
  c.g = c.g > 255 and 255 or c.g
  c.b = c.b + amount
  c.b = c.b < 0 and 0 or c.b
  c.b = c.b > 255 and 255 or c.b

  return string.format("#%02x%02x%02x", c.r, c.g, c.b)
end

--- Darken a color.
--
-- @string color The color to darken with hexadecimal HTML format `"#RRGGBB"`.
-- @int[opt=26] amount How much dark from 0 to 255. Default is around 10%.
-- @treturn string The darker color
function M.darken(color, amount)
  amount = amount or 26
  return M.lighten(color, -amount)
end

return M
