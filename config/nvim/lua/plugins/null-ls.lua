---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local M = {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
}

M.config = function()
    local nls = require("null-ls")

    -- Declaring the formatting on save augroup here to avoid redefining it every time
    local formatting_on_save = vim.api.nvim_create_augroup("formatting_on_save", { clear = true })

    local function use_if_exec_exists(provider, exec)
        return vim.fn.executable(exec) > 0 and provider or nil
    end

    nls.setup({
        cmd = { "nvim" }, -- required to start the nls server.
        diagnostics_format = "[#{s}:#{c}] #{m}",
        log_level = "info",
        on_attach = function(client, bufnr)
            -- Get the default on attach, we are going to expand on this.
            local config = require("plugins.lsp.config-manager").get_config("null-ls")
            config.on_attach(client, bufnr)

            -- Formatting on save.
            vim.api.nvim_clear_autocmds({ group = formatting_on_save, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = formatting_on_save,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end,
        sources = {
            use_if_exec_exists(nls.builtins.formatting.stylua, "stylua"),
            use_if_exec_exists(nls.builtins.diagnostics.luacheck, "luacheck"),
        },
    })
end

return M
