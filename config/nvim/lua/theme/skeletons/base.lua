---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local theme = require("theme")
---@type ThemePaletteColors, ThemePaletteBase16
local C, B = theme.colors, theme.base16

return {
    -- stylua: ignore start
    Normal = { fg = B.BASE05, bg = B.BASE00 },
    Bold = { bold = true, italic = false, underline = false },
    Debug = { fg = B.BASE08 },
    Directory = { fg = B.BASE0D },
    Error = { fg = B.BASE08, bold = true },
    ErrorMsg = { link = "Error" },
    Exception = { link = "Error" },
    FoldColumn = { fg = B.BASE03, bg = B.BASE00 },
    Folded = { fg = B.BASE03, bg = B.BASE01 },
    IncSearch = { fg = B.BASE01, bg = B.BASE0A },
    Italic = { bold = false, italic = true, underline = false },
    MatchParen = { bg = B.BASE03, bold = true },
    ModeMsg = { fg = B.BASE0B, bold = true },
    MoreMsg = { fg = B.BASE0B, bold = true },
    Question = { fg = B.BASE0D, bold = true },
    Search = { fg = B.BASE01, bg = B.BASE0A },
    Substitute = { fg = B.BASE01, bg = B.BASE0A },
    SpecialKey = { fg = B.BASE03, italic = true },
    TooLong = { fg = B.BASE08 },
    Underlined = { bold = false, italic = false, underline = true },
    Visual = { bg = B.BASE02 },
    VisualNOS = { link = "Visual" },
    WarningMsg = { fg = B.BASE0A, bold = true },
    WildMenu = { fg = B.BASE0B, bg = B.BASE02, bold = true },
    Title = { fg = B.BASE0D },
    Conceal = { fg = B.BASE0D, bg = B.BASE00, bold = true },
    Cursor = { fg = B.BASE0A, bg = B.BASE05 },
    NonText = { fg = B.BASE03 },
    LineNr = { fg = B.BASE03, bg = B.BASE00 },
    SignColumn = { fg = "none", bg = "none", sp = "none" }, -- match Normal hl grou.
    StatusLine = { bg = C.statusline, fg = B.BASE04 },
    StatusLineNC = { bg = C.statusline, fg = B.BASE04 },
    VertSplit = { bg = "none", fg = C.statusline },
    ColorColumn = { bg = B.BASE01 },
    CursorColumn = { bg = B.BASE00 },
    CursorLine = { bg = B.BASE00 },
    CursorLineNr = { fg = B.BASE05, bg = B.BASE00, bold = true },
    QuickFixLine = { bg = B.BASE01 },
    PMenu = { fg = B.BASE05, bg = B.BASE01 },
    PMenuSel = { fg = B.BASE0D, bg = B.BASE02, bold = true }, -- not following base16
    PMenuSbar = { fg = B.BASE05, bg = B.BASE01 },
    PMenuThumb = { fg = C.oneb3, bg = C.oneb3 },
    TabLine = { fg = C.grey_fg, bg = C.onebg },
    TabLineFill = { fg = C.grey_fg, bg = C.statusline },
    TabLineSel = { fg = B.BASE05, bg = B.BASE00, bold = true },
    -- The following are specified in the base16 standard?
    NormalFloat = { bg = "none" },
    FloatBorder = { fg = C.oneb2, bg = "none" },
    -- Spelling
    SpellBad = { undercurl = true, sp = C.red },
    SpellCap = { undercurl = true, sp = C.blue },
    SpellLocal = { undercurl = true, sp = C.green },
    SpellRare = { undercurl = true, sp = C.magenta },
    -- Builtin LSP client highlights.
    DiagnosticError = { fg = C.red, bold = true },
    DiagnosticWarn = { fg = C.yellow, bold = true },
    DiagnosticInfo = { fg = C.blue, bold = true },
    DiagnosticHint = { fg = C.grey, bold = false },
    DiagnosticVirtualTextError = { fg = C.red, bold = true },
    DiagnosticVirtualTextWarn = { fg = C.yellow, bold = true },
    DiagnosticVirtualTextInfo = { fg = C.blue, bold = true },
    DiagnosticVirtualTextHint = { fg = C.grey, bold = false },
    DiagnosticUnderlineError = { sp = C.red, underline = true },
    DiagnosticUnderlineWarn = { sp = C.yellow, underline = true },
    DiagnosticUnderlineInfo = { sp = C.blue, underline = true },
    DiagnosticUnderlineHint = { sp = C.grey, underline = false },
    -- stylua: ignore end
}
