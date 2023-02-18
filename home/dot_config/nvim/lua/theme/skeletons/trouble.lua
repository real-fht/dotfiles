---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.skeletons.notify'
---------------------------------------------------------------------------------

local theme = require("theme")
---@type ThemePaletteColors, ThemePaletteBase16
local C, B = theme.colors, theme.base16

return {
  -- stylua: ignore start
  TroubleCount = { fg = C.blue, bold = true },
  TroubleError = { fg = C.red, bold = true },
  TroubleNormal = { bg = C.darker_black },
  TroubleLocation = { fg = C.grey, italic = true },
  TroubleIndent = { bg = C.darker_black, fg = C.onebg, bold = true },
  TroubleFoldIcon = { bg = C.darker_black, fg = C.oneb2 },
  -- stylua: ignore end
}
