---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
}

M.config = function()
    local indentline = require("indent_blankline")

    indentline.setup({
        char = "│", -- I prefer it thicker
        context_char = "│", -- I prefer it thicker
        char_list = {}, -- only use $char for all levels.
        use_treesitter = true, -- more accurate results.
        show_first_indent_level = false,
        filetype_exclude = { "lspinfo", "packer", "checkhealth", "help", "mason", "neo-tree" },
        buftype_exclude = { "terminal", "nofile", "quickfix", "prompt" },
        show_current_context = true, -- requires nvim-treesitter
        show_current_context_start = true,
        use_treesitter_scope = true,
    })

    local C = require("theme").colors
    vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = C.oneb2, bold = true })
    vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = C.oneb2, bold = true })
    vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", { bg = "none" })
end

return M
