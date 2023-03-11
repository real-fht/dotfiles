---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local M = {
    "utilyre/barbecue.nvim",
    -- event = "VeryLazy",
    dependencies = { "neovim/nvim-lspconfig", "smiteshp/nvim-navic", "nvim-tree/nvim-web-devicons" },
    enabled = true,
}

M.config = function()
    local barbecue = require("barbecue")

    barbecue.setup({ attach_navic = true })
    require("theme").load_skeleton("barbecue")

    vim.keymap.set("n", "<leader>tB", ":Barbecue toggle<CR>", { desc = "Toggle breadcrumbs" })
end

return M
