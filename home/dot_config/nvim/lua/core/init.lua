---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'core'
---------------------------------------------------------------------------------

-- Disables Neovim's builtin plugins (bundled in $VIMRUNTIME)
do
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  -- vim.g.loaded_matchit = 1
  -- vim.g.loaded_matchparen = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_rrhelper = 1
  -- vim.g.loaded_netrw = 1
  -- vim.g.loaded_netrwPlugin = 1
  -- vim.g.loaded_netrwSettings = 1
  -- vim.g.loaded_netrwFileHandlers = 1
end

-- Disable checking for providers.
do
  vim.g.loaded_python_provider = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_perl_provider = 0
end

-- Map leader key to space.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocmd")
require("core.plugins")

-- Colorscheme
vim.cmd.colorscheme("themer")
