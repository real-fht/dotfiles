---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local theme = require("theme")
---@type ThemePaletteColors, ThemePaletteBase16
local C, B = theme.colors, theme.base16

return {
    -- stylua: ignore start

    LspReferenceRead = { bg = C.onebg, bold = true },
    LspReferenceWrite = { bg = C.onebg, bold = true },
    LspReferenceText = { bg = C.onebg, bold = true },

    LspHoverBorder = { fg = C.onebg, bold = true },
    LspSignatureHelpBorder = { fg = C.onebg, bold = true },

    -- stylua: ignore end
}
