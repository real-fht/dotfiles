---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'modules.lang.lspconfig.config-manager'
---------------------------------------------------------------------------------

local M = {}

---From the nvim-lspconfig README.md file:
--- "Use on_attach function to only map the following keys after the
--  language server attaches to the current buffer"
local on_attach = function(client, bufnr)
  -- LSP-based keymaps when the client attaches
  local set_keymap = vim.keymap.set
  set_keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Symbol Declaration", buffer = bufnr })
  set_keymap("n", "gd", vim.lsp.buf.definition, { desc = "Symbol Definition", buffer = bufnr })
  set_keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover Symbol", buffer = bufnr })
  set_keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Symbol Implementation", buffer = bufnr })
  set_keymap("n", "gr", vim.lsp.buf.rename, { desc = "Rename Symbol", buffer = bufnr })
  set_keymap("n", "gC", vim.lsp.buf.code_action, { desc = "Buffer Code Action(s)", buffer = bufnr })
  set_keymap("n", "gR", vim.lsp.buf.references, { desc = "Symbol References", buffer = bufnr })
  set_keymap("n", "gf", vim.lsp.buf.format, { desc = "LSP Format", buffer = bufnr })
  set_keymap("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Open Signature Help", buffer = bufnr })

  ---Use a telescope picker without having to load telescope
  ---@param picker string
  ---@return function
  local use_telescope = function(picker)
    return function()
      require("telescope")[picker]()
    end
  end

  set_keymap("n", "<leader>fd", use_telescope("diagnostics"), { desc = "Workspace Diagnostics", buffer = bufnr })

  -- Show diagnostics in popup
  vim.opt.updatetime = 250 -- faster.
  vim.api.nvim_create_autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("lsp_diagnostic_popup", { clear = true }),
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })

  -- Document highlighting(aka: symbol highlighting)
  -- if client.server_capabilities.documentHighlightProvider then
  --     vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
  --     vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
  --     -- -*- Actually setting the autocmds
  --     vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  --         group = "lsp_document_highlight",
  --         buffer = bufnr,
  --         callback = vim.lsp.buf.document_highlight,
  --     })
  --     vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  --         group = "lsp_document_highlight",
  --         buffer = bufnr,
  --         callback = vim.lsp.buf.clear_references,
  --     })
  -- end

  -- Winbar symbols. ()
  -- if client.server_capabilities.documentSymbolProvider and pcall(require, "nvim-navic") then
  -- require("nvim-navic").attach(client, bufnr)
  -- vim.bo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  -- end
end

---@return table
local generate_capabilities = function()
  local default_capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_nvim_lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
  return vim.tbl_extend("keep", cmp_nvim_lsp_capabilities, default_capabilities)
end

---@return table
local get_handlers = function()
  local function make_border(hl_group)
    return {
      { "╭", hl_group },
      { "─", hl_group },
      { "╮", hl_group },
      { "│", hl_group },
      { "╯", hl_group },
      { "─", hl_group },
      { "╰", hl_group },
      { "│", hl_group },
    }
  end

  -- Override per handler so i can customize the border hl group
  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = make_border("LspHoverBorder") }),
    ["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = make_border("LspSignatureHelpBorder") }
    ),
  }

  return handlers
end

---@class LspServerConfiguration
---@field on_attach function
---@field capabilities table

---@type LspServerConfiguration
M.default_config = {
  on_attach = on_attach,
  capabilities = generate_capabilities(),
  handlers = get_handlers(),
}

---@param server_name string
---@returns LspServerConfiguration
M.get_config = function(server_name)
  local ok, overrides = pcall(require, "plugins.lsp." .. server_name)

  if ok and type(overrides) == "table" then
    -- If some custom keys for a server already exists, use the overrides
    -- specified there then.
    return vim.tbl_extend("keep", M.default_config, overrides)
  end

  return M.default_config
end

return M
