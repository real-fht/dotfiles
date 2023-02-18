---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.skeletons.base'
---------------------------------------------------------------------------------

---@type ThemePaletteBase16
local B = require("theme").base16

return {
  -- stylua: ignore start
  -- `@annotation` is not one of the default capture group, should we keep it
  ["@annotation"] = { fg = B.BASE0F },
  ["@attribute"] = { fg = B.BASE0A },
  ["@character"] = { fg = B.BASE08, bold = true },
  ["@constructor"] = { fg = B.BASE0C },
  ["@constant.builtin"] = { fg = B.BASE09 },
  ["@constant.macro"] = { fg = B.BASE08 },
  ["@error"] = { fg = B.BASE08 },
  ["@exception"] = { fg = B.BASE08 },
  ["@float"] = { fg = B.BASE09 },
  ["@keyword"] = { fg = B.BASE0E },
  ["@keyword.function"] = { fg = B.BASE0E },
  ["@keyword.return"] = { fg = B.BASE0E },
  ["@function"] = { fg = B.BASE0D },
  ["@function.builtin"] = { fg = B.BASE0D },
  ["@function.macro"] = { fg = B.BASE08 },
  ["@keyword.operator"] = { fg = B.BASE0E },
  ["@method"] = { fg = B.BASE0D },
  ["@namespace"] = { fg = B.BASE08 },
  ["@none"] = { fg = B.BASE05 },
  ["@parameter"] = { fg = B.BASE0A },
  -- ["@reference"] = { fg = B.BASE05 },
  ["@punctuation.bracket"] = { fg = B.BASE0F },
  ["@punctuation.delimiter"] = { fg = B.BASE0F },
  ["@punctuation.special"] = { fg = B.BASE08 },
  ["@string.regex"] = { fg = B.BASE0C },
  ["@string.escape"] = { fg = B.BASE0C },
  ["@symbol"] = { fg = B.BASE0B },
  ["@tag"] = { link = "Tag" },
  ["@tag.attribute"] = { link = "@property" },
  ["@tag.delimiter"] = { fg = B.BASE0F },
  ["@text"] = { fg = B.BASE05 },
  ["@text.strong"] = { bold = true },
  ["@text.emphasis"] = { fg = B.BASE09 },
  ["@text.strike"] = { fg = B.BASE00, strikethrough = true },
  ["@text.literal"] = { fg = B.BASE09 },
  ["@text.uri"] = { fg = B.BASE09, underline = true },
  ["@type.builtin"] = { fg = B.BASE0A },
  ["@variable"] = { fg = B.BASE05 },
  ["@variable.builtin"] = { fg = B.BASE09 },
  ["@definition"] = { sp = B.BASE04, underline = true },
  TSDefinitionUsage = { sp = B.BASE04, underline = true },
  ["@scope"] = { bold = true },
  ["@field"] = { fg = B.BASE08 },
  ["@property"] = { fg = B.BASE08 },
  ["@include"] = { link = "Include" },
  ["@conditional"] = { link = "Conditional" },

  ["@doctool.annotation"] = { link = "@annotation" },
  -- stylua: ignore end
}
