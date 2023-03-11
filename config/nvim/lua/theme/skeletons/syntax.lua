---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

---@type ThemePaletteBase16
local B = require("theme").base16

return {
    -- stylua: ignore start

    -- Neovim base syntax.
    Boolean = { fg = B.BASE09, bold = true },
    Character = { fg = B.BASE09, bold = true },
    Comment = { fg = B.BASE03, italic = true },
    Conditional = { fg = B.BASE0E, italic = true },
    Constant = { fg = B.BASE09 },
    Define = { fg = B.BASE0E, sp = "none" },
    Delimiter = { fg = B.BASE0F },
    Float = { fg = B.BASE09, bold = true },
    Function = { fg = B.BASE0D, italic = true },
    Identifier = { fg = B.BASE08, sp = "none" },
    Include = { fg = B.BASE0D, bold = true },
    Keyword = { fg = B.BASE0E, italic = true },
    Label = { fg = B.BASE0A },
    Number = { fg = B.BASE09 },
    Operator = { fg = B.BASE05, sp = "none" },
    PreProc = { fg = B.BASE0A },
    Repeat = { fg = B.BASE0A, italic = true },
    Special = { fg = B.BASE0C },
    SpecialChar = { fg = B.BASE0F, bold = true },
    Statement = { fg = B.BASE08 },
    StorageClass = { fg = B.BASE0A },
    String = { fg = B.BASE0B },
    Structure = { fg = B.BASE0E },
    Tag = { fg = B.BASE0A },
    Todo = { fg = B.BASE0A, bg = B.BASE01 },
    Type = { fg = B.BASE0A, bold = true },
    TypeDef = { link = "type" },

    -- .diff files highlighting.
    DiffAdd = { fg = B.BASE0B, bg = B.BASE01 },
    DiffChange = { fg = B.BASE0C, bg = B.BASE01 },
    DiffDelete = { fg = B.BASE08, bg = B.BASE01 },
    DiffText = { fg = B.BASE0D, bg = B.BASE01 },
    DiffAdded = { fg = B.BASE0B, bg = B.BASE00 },
    DiffFile = { fg = B.BASE08, bg = B.BASE00 },
    DiffNewFile = { fg = B.BASE0B, bg = B.BASE00 },
    DiffLine = { fg = B.BASE0D, bg = B.BASE00 },
    DiffRemoved = { fg = B.BASE08, bg = B.BASE00 },

    -- stylua: ignore end
}
