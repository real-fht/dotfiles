---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.skeletons.telescope'
---------------------------------------------------------------------------------

local theme = require("theme")
---@type ThemePaletteColors, ThemePaletteBase16
local C, B = theme.colors, theme.base16

return {
  -- stylua: ignore start
  TelescopeNormal = { bg = C.black2, fg = C.white },
  TelescopeBorder = { bg = C.black2, fg = C.black2 },
  TelescopeMultiIcon = { fg = C.red, bold = true },
  TelescopeMultiSelection = { fg = C.yellow, bold = true },
  TelescopeSelection = { bg = C.onebg },
  TelescopeSelectionCaret = { bg = C.onebg, fg = C.blue },
  TelescopeMatching = { fg = C.blue, bold = true, italic = true },
  TelescopePromptCounter = { fg = C.light_grey },
  -- -*-
  TelescopePreviewBorder = { bg = C.darker_black, fg = C.darker_black },
  TelescopeResultsBorder = { bg = C.black2, fg = C.black2 },
  TelescopePromptBorder = { bg = C.onebg, fg = C.onebg },
  -- -*-
  TelescopePreviewNormal = { bg = C.darker_black, fg = C.white },
  TelescopeResultsNormal = { bg = C.black2, fg = C.white },
  TelescopePromptNormal = { bg = C.onebg, fg = C.white },
  -- -*-
  TelescopePreviewTitle = { bg = C.red, fg = C.darker_black, bold = true },
  TelescopePromptTitle = { bg = C.blue, fg = C.onebg, bold = true },
  TelescopeResultsTitle = { bg = C.black2, fg = C.black2 },
  -- -*-
  TelescopePreviewMessageFillchar = { fg = C.grey_fg },
  TelescopePreviewMessage = { fg = C.white, bold = true },
  TelescopePreviewNormal = { bg = C.darker_black },
  -- stylua: ignore end
}
