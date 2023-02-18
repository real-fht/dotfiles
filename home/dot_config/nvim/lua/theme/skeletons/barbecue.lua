---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.skeletons.barbecue'
---------------------------------------------------------------------------------

local theme = require("theme")
local C, B = theme.colors, theme.base16

return {
  barbecue_context_File = { bg = "none", fg = C.red },
  barbecue_context_Module = { bg = "none", fg = C.yellow },
  barbecue_context_Namespace = { bg = "none", fg = C.blue },
  barbecue_context_Package = { link = "NavicIconsModule" },
  barbecue_context_Class = { bg = "none", fg = C.blue },
  barbecue_context_Function = { bg = "none", fg = B.BASE0E },
  barbecue_context_Method = { link = "CmpItemKindFunction" },
  barbecue_context_Property = { bg = "none", fg = C.light_grey },
  barbecue_context_Field = { bg = "none", fg = C.blue },
  barbecue_context_Constructor = { bg = "none", fg = B.BASE0A },
  barbecue_context_Enum = { bg = "none", fg = C.blue },
  barbecue_context_Interface = { bg = "none", fg = C.blue },
  barbecue_context_Variable = { bg = "none", fg = C.cyan },
  barbecue_context_Constant = { bg = "none", fg = B.BASE09 },
  barbecue_context_String = { bg = "none", fg = B.BASE0B },
  barbecue_context_Number = { bg = "none", fg = B.BASE09 },
  barbecue_context_Boolean = { bg = "none", fg = B.BASE09 },
  barbecue_context_Array = { bg = "none", fg = C.grey_fg },
  barbecue_context_Object = { bg = "none", fg = C.red },
  barbecue_context_Event = { bg = "none", fg = C.blue },
  barbecue_context_Operator = { bg = "none", fg = B.BASE03 },
  barbecue_context_TypeParameter = { bg = "none", fg = B.BASE0A },
  barbecue_normal = { bg = C.black },
  barbecue_separator = { fg = C.grey },
  barbecue_dirname = { fg = C.light_grey, italic = true },
  barbecue_basename = { fg = C.white, bold = true },
  barbecue_context = { fg = C.white },
  -- stylua: ignore end
}
