---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPre",
    dependencies = {
        { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle", enabled = false },
    },
}

M.config = function()
    local treesitter_configs = require("nvim-treesitter.configs")
    local filetype_to_parsername = require("nvim-treesitter.parsers").filetype_to_parsername

    treesitter_configs.setup({
        ensure_installed = { "lua", "vim" },
        sync_install = true, -- install synchronously for $ensure_installed.
        auto_install = true, -- installs missing parsers on filetype opening.

        -- Treesitter modules.
        -- `highlight`, `incremental_selection` and `indent` are builtin!
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
        indent = { enable = true },

        -- Requires https://github.com/RRethy/nvim-treesitter-endwise
        endwise = { enable = true },

        -- Requires https://github.com/windwp/nvim-ts-autotag
        autotag = { enable = true },

        -- Requires https://github.com/JoosepAlviste/nvim-ts-context-commentstring
        context_commentstring = { enable = true, enable_autocmd = false },
    })

    -- Override what parsers to use for filetypes.
    filetype_to_parsername.zsh = "bash"
    filetype_to_parsername.conf = "toml"

    require("theme").load_skeleton("treesitter")
end

return M
