---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'core.autocmd'
---------------------------------------------------------------------------------

local api = vim.api

-- Create a personal autogroup to avoid polluting the main autocommand
-- namespace.
local fht = api.nvim_create_augroup("fht", { clear = true })

api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Trim Trailing whitespace from buffers",
  group = fht,
  pattern = "*",
  callback = function()
    local view = vim.call("winsaveview")
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.call("winrestview", view)
  end,
})

api.nvim_create_autocmd({ "FileType" }, {
  desc = "Enable wrapping and spellchecking for filetypes",
  group = fht,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true ---@diagnostic disable-line
    vim.opt_local.wrap = true ---@diagnostic disable-line
  end,
})

api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Fixes Window sizes when Neovim terminal gets resized",
  group = fht,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight on yank",
  group = fht,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

api.nvim_create_autocmd({ "FocusGained" }, {
  desc = "More eager checking for files changes outside Neovim",
  group = fht,
  command = "checktime",
})

api.nvim_create_autocmd({ "BufEnter" }, {
  desc = "Settings for terminal buffers ",
  pattern = { "terminal", "term://*" },
  group = fht,
  command = "set nonumber norelativenumber signcolumn=yes",
})

api.nvim_create_autocmd({ "BufWinEnter" }, {
  desc = "Enter insert mode when focusing terminal",
  pattern = { "terminal", "term://*" },
  group = fht,
  command = "startinsert",
})
