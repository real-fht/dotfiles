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
  NotifyBorder = { fg = C.oneb2, bg = "none" },
  NotifyERRORBorder = { link = "NotifyBorder" },
  NotifyWARNBorder = { link = "NotifyBorder" },
  NotifyINFOBorder = { link = "NotifyBorder" },
  NotifyDEBUGBorder = { link = "NotifyBorder" },
  NotifyTRACEBorder = { link = "NotifyBorder" },
  -- -*-
  NotifyERRORTitle = { fg = C.red, bg = "none" },
  NotifyWARNTitle = { fg = C.yellow, bg = "none" },
  NotifyINFOTitle = { fg = C.blue, bg = "none" },
  NotifyDEBUGTitle = { fg = C.magenta, bg = "none" },
  NotifyTRACETitle = { fg = C.magenta, bg = "none", bold = true },
  -- -*-
  NotifyERRORBody = { fg = C.white, bg = "none" },
  NotifyWARNBody = { fg = C.white, bg = "none" },
  NotifyINFOBody = { fg = C.white, bg = "none" },
  NotifyDEBUGBody = { fg = C.white, bg = "none" },
  NotifyTRACEBody = { fg = C.white, bg = "none", bold = true },
  -- -*-
  NotifyERRORIcon = { link = "NotifyERRORTitle" },
  NotifyWARNIcon = { link = "NotifyWARNTitle" },
  NotifyINFOIcon = { link = "NotifyINFOTitle" },
  NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
  NotifyTRACEIcon = { link = "NotifyTRACETitle" },
  -- -*-
  NotifySeparator = { fg = C.oneb2, bg = "none" },
  -- stylua: ignore end
}
