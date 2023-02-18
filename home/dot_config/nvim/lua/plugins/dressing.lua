---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.dressing'
---------------------------------------------------------------------------------

local M = {
  "stevearc/dressing.nvim",
  lazy = false,
}

-- M.init = function()
--     vim.ui.old_select = vim.ui.select
--     vim.ui.select = function(items, opts, on_choice)
--         -- require('lazy').load({ plugins = { 'dressing.nvim' } })
--         vim.cmd('Lazy load dressing.nvim')
--         vim.ui.old_select(items, opts, on_choice)
--     end
-- end

M.config = function()
  local dressing = require("dressing")

  dressing.setup({
    input = {
      -- Override vim.ui.input() hook
      enabled = true,
      prompt_align = "center",
      insert_only = true,
      start_in_insert = true,
      border = "rounded",
      relative = "cursor", -- depends
      win_options = { winblend = 0.0 },
      -- Set to `false` to disable
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<Up>"] = "HistoryPrev",
          ["<Down>"] = "HistoryNext",
        },
      },
    },
    select = {
      -- Override vim.ui.select() hook
      enabled = true,
      backend = { "telescope", "builtin" },
      telescope = {
        layout_strategy = "horizontal",
        layout_config = { width = 0.4, height = 0.5 },
      },
      builtin = {
        -- Just in case it's used.
        border = "rounded",
        mappings = {
          ["<Esc>"] = "Close",
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
        },
      },
    },
  })

  local colors = require("theme").colors
  vim.api.nvim_set_hl(0, "FloatTitle", { fg = colors.blue, bold = true })
end

return M
