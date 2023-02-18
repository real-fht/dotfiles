---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'core.plugins'
---------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
-- Add lazy to rtp so we can use it
vim.opt.runtimepath:prepend(lazypath)

-- Plugin definitions are inside submodules
require("lazy").setup("plugins", {
  root = vim.fn.stdpath("data") .. "/lazy",
  defaults = { lazy = true, version = nil },
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  install = { missing = true, colorscheme = { "themer" } },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
    },
  },
})
