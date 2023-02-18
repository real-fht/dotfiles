---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.noice'
---------------------------------------------------------------------------------

local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "rcarriga/nvim-notify" },
    -- Noice is very laggy, rather have a classic cmdline etc
    -- enabled = false,
}

M.config = function()
    local noice = require("noice")

    noice.setup({
        cmdline = {
            enable = true,
            view = "cmdline_popup",
            opts = {}, -- See section of views.
            ---@type table<string, CmdLineFormat>
            format = {
                -- This section is composed of tables that contain generally the following
                -- keys: pattern(when to enable the prompt), icon(what icon to display at the
                -- left of the prompt), lang(what treesitter parser to use for the popup)
                -- stylua: ignore start
                cmdline = { pattern = "^:", icon = " ", lang = "vim" },
                search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                filter = { pattern = "^:!", icon = " $", lang = "bash" },
                lua = { pattern = "^:%s*lua%s+", icon = " ", lang = "lua" },
                help = { pattern = "^:%s*he?l?p?%s+", icon = " " },
                -- stylua: ignore end
            },
        },

        messages = {
            -- How to display different messages.
            -- Enabling this will automatically enable the cmdline due to a neovim
            -- limitation for extensible UI hooks.
            enabled = true,
            -- stylua: ignore start
            view = "notify",
            view_error = "notify",
            view_warn = "notify",
            view_history = "notify",
            view_search = "virtualtext",
            -- stylua: ignore end
        },

        popupmenu = {
            -- Replaces the default PMenu that comes with the cmdline.
            enabled = true,
            backend = "nui",
            kind_icons = {},
        },

        notify = {
            -- Use `vim.notify` to route notifications to pretty popup UIs.
            enabled = true,
            view = "notify",
        },

        views = {
            cmdline_popup = {
                position = { row = 5, col = "50%" },
                size = { width = 80, height = "auto" },
                -- border = { style = "solid", padding = { 0, 3 } },
            },
            popupmenu = {
                relative = "editor",
                position = { row = 8, col = "50%" },
                size = { width = 80, height = 10 },
                border = { style = "solid", padding = { 0, 1 } },
            },
        },

        lsp = {
            progress = { enabled = true, view = "mini" },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            hover = {
                enabled = false,
                view = nil,
                opts = {
                    border = { type = "solid" },
                    win_options = { winhighlight = "Normal:NoiceHoverNormal,FloatBorder:NoiceHoverBorder" },
                },
            },
            signature = {
                enabled = false,
                view = nil,
                opts = {
                    border = { type = "solid" },
                    -- position = function()
                    --     local position_params = vim.lsp.util.make_position_params()
                    --     return { row = position_params.position.line, col = position_params.position.character }
                    -- end,
                    win_options = { winhighlight = "Normal:NoiceSignatureNormal,FloatBorder:NoiceSignatureBorder" },
                },
            },
        },
        presets = { lsp_doc_border = true, long_message_to_split = true },
    })

    require("theme").load_skeleton("noice")
end

return M
