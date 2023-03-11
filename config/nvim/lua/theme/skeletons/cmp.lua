---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local theme = require("theme")
---@type ThemePaletteColors, ThemePaletteBase16
local C, B = theme.colors, theme.base16

return {
    -- stylua: ignore start
    CmpCompletionNormal = { bg = C.black2, fg = C.white },
    CmpCompletionBorder = { bg = C.black2, fg = C.black2 },
    CmpDocumentationNormal = { bg = C.onebg, fg = C.white },
    CmpDocumentationBorder = { bg = C.onebg, fg = C.onebg },
    -- -*-
    CmpItemAbbrDeprecated = { bg = "none", fg = C.grey_fg, strikethrough = true },
    CmpItemKindSnippet = { bg = "none", fg = C.grey_fg },
    CmpFolderIcon = { bg = "none", fg = C.blue },
    CmpFileIcon = { bg = "none", fg = C.red },
    -- -*-*-
    CmpItemAbbrMatch = { bg = "none", fg = C.blue, bold = true },
    CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
    -- -*-*-
    CmpItemKindVariable = { bg = "none", fg = C.cyan },
    CmpItemKindInterface = { link = "CmpItemKindVariable" },
    CmpItemKindText = { link = "CmpItemKindVariable" },
    -- -*-*-
    CmpItemKindFunction = { bg = "none", fg = C.magenta },
    CmpItemKindMethod = { link = "CmpItemKindFunction" },
    -- -*-*-
    CmpItemKindKeyword = { bg = "none", fg = C.light_grey },
    CmpItemKindProperty = { link = "CmpItemKindKeyword" },
    CmpItemKindUnit = { link = "CmpItemKindKeyword" },

    -- stylua: ignore end
}
