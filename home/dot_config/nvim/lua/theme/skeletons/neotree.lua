---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.skeletons.neotree'
---------------------------------------------------------------------------------

local theme = require("theme")
---@type ThemePaletteColors, ThemePaletteBase16
local C, B = theme.colors, theme.base16

return {
  -- stylua: ignore start
  NeotreeNormal = { bg = C.black },
  NeotreeNormalNC = { bg = C.black },
  NeotreeCursorline = { bg = C.black, bold = true },
  NeotreeVertSplit = { bg = C.black, fg = C.black },
  NeotreeWinSeparator = { link = "NeotreeVertSplit" },
  NeotreeSignColumn = { bg = C.black, bold = true },
  NeotreeEndOfBuffer = { bg = C.black, fg = C.black },
  NeotreeBufferNumber = { fg = C.blue, bold = true },
  NeotreeDotFile = { fg = C.grey, italic = true },
  NeotreeHiddenByName = { link = "NeotreeDotFile" },
  NeotreeDirectoryName = { fg = C.blue },
  NeotreeFileName = { fg = C.white },
  NeotreeFileNameOpened = { fg = C.white, bg = C.onebg, bold = true },
  NeotreeSymbolicLinkTarget = { link = "NeotreeFileName" },
  NeotreeFilterTerm = { fg = C.blue, bold = true },
  NeotreeIndentMarker = { fg = C.oneb2 },
  NeotreeModified = { fg = C.red, bold = true },
  -- -*-
  NeotreeGitAdded = { fg = C.green },
  NeotreeGitDeleted = { fg = C.yellow },
  NeotreeGitModified = { fg = C.red, bold = true },
  NeotreeGitConflict = { fg = C.yellow, italic = true },
  NeotreeGitIgnored = { fg = C.light_grey },
  NeotreeGitRenamed = { fg = C.yellow },
  NeotreeGitStaged = { fg = C.green },
  NeotreeGitUnstaged = { fg = C.yellow },
  NeotreeGitUntracked = { fg = C.yellow },
  -- stylua: ignore end
}
