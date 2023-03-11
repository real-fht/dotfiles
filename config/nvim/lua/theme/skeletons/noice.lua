---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local theme = require("theme")
---@type ThemePaletteColors, ThemePaletteBase16
local C, B = theme.colors, theme.base16

return {
    -- stylua: ignore start
    NoiceCmdLine = { bg = C.onebg },
    NoiceCmdLineIcon = { bg = C.onebg, fg = C.blue },
    NoiceCmdLineIconCmdLine = { bg = C.onebg, fg = C.blue },
    NoiceCmdLineIconFilter = { bg = C.onebg, fg = C.green, bold = true },
    NoiceCmdLineIconHelp = { bg = C.onebg, fg = C.magenta },
    NoiceCmdLineIconSearch = { bg = C.onebg, fg = C.yellow },
    NoiceCmdLinePopup = { bg = C.onebg },
    NoiceCmdLinePopupBorder = { bg = C.onebg, fg = C.onebg },
    NoiceCmdLinePopupBorderSearch = { link = "NoiceCmdLinePopupBorder" },
    NoicePopupMenu = { bg = C.black2 },
    NoicePopupMenuBorder = { bg = C.black2, fg = C.black2 },
    NoicePopupMenuSelected = { bg = C.onebg, fg = C.blue, bold = true },
    -- -*-
    NoiceHoverNormal = { bg = C.black2 },
    NoiceSignatureNormal = { bg = C.black2 },
    NoiceHoverBorder = { bg = C.black2, fg = C.black2 },
    NoiceSignatureBorder = { bg = C.black2, fg = C.black2 },
    -- stylua: ignore end
}
