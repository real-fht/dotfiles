---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.luasnip'
---------------------------------------------------------------------------------

local M = {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
}

M.config = function()
  local luasnip = require("luasnip")

  -- Load snippets (requires friendly-snippets or something similar)
  require("luasnip.loaders.from_vscode").lazy_load()

  luasnip.config.set_config({
    history = true,
    update_events = "InsertLeave,TextChanged,TextChangedI",
    region_check_events = "CursorMoved,CursorHold,InsertEnter",
    delete_check_events = "TextChanged,InsertLeave",
  })
end

return M
