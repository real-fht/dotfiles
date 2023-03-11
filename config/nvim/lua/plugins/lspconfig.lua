---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local M = {
    "neovim/nvim-lspconfig",
    event = "BufRead",
}

M.config = function()
    -- Diagnostic keymaps, since they're global
    vim.keymap.set("n", "<leader>l@", vim.diagnostic.open_float)
    vim.keymap.set({ "n", "i" }, "<C-S-;>", vim.diagnostic.goto_next)
    vim.keymap.set({ "n", "i" }, "<C-S-:>", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "<space>lD", vim.diagnostic.setloclist)

    -- Override the floating preview function to force a custom border style.
    -- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    -- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    --     opts = opts or {}
    --     opts.border = opts.border or "solid"
    --     return orig_util_open_floating_preview(contents, syntax, opts, ...)
    -- end
    -- Setup how diagnostics are displayed (:help vim.diagnostic.config)
    vim.diagnostic.config({
        underline = true, -- underline the area with diagnostics
        virtual_text = true and false or {
            enabled = false,
            source = "if_many",
            prefix = "",
        },
        signs = false,
        update_in_insert = true, -- I'd rather this behaviour.
        severity_sort = true,
        float = {
            header = "",
            prefix = "",
            border = "rounded",
            style = "minimal",
        },
    })

    -- Use different signs.
    for type, icon in pairs({ Error = "", Warn = "", Hint = "", Info = "" }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Setup installed lsp servers.
    for server, executable in pairs({
        lua_ls = "lua-language-server",
        nil_ls = "nil",
        tsserver = "typescript-language-server",
        cssls = "vscode-css-language-server",
        html = "vscode-html-language-server",
        jsonls = "vscode-json-language-server",
    }) do
        if vim.fn.executable(executable) > 0 then
            local config = require("plugins.lsp.config-manager").get_config(server)
            require("lspconfig")[server].setup(config)
        end
    end

    require("theme").load_skeleton("lspconfig")
end

return M
