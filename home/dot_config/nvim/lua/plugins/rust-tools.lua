---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.notify'
---------------------------------------------------------------------------------

local M = {
  "simrat39/rust-tools.nvim",
  ft = "rust",
}

M.config = function()
  local rt = require("rust-tools")

  rt.setup({
    -- Get our classic server configuration from lsp config manager.
    server = require("plugins.lsp.config-manager").get_config("rust_analyzer"),
  })
end

return M
