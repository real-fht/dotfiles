---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'modules.pack'
---------------------------------------------------------------------------------

local M = {}

local PACKER_INSTALL_PATH = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

function M.ensure_packer()
  -- Checks for packer availability in the 1st place.
  local ok, packer = pcall(require, "packer")
  local directory_ok = vim.fn.isdirectory(PACKER_INSTALL_PATH) > 0

  if not ok and directory_ok then
    vim.notify(
      "Unable to require packer.nvim even though it's install directory\n"
        .. "exists. Removing the directory right ahead, please restart Neovim.",
      vim.log.levels.WARN
    )
    vim.fn.delete(PACKER_INSTALL_PATH, "rf")
  end

  if not ok then
    _G.packer_bootstrapped = true
    vim.notify("Installing packer.nvim to: " .. PACKER_INSTALL_PATH, vim.log.levels.INFO)
    vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", PACKER_INSTALL_PATH })
    pcall(vim.api.nvim_command, "packadd! packer.nvim") -- try to load again for checking.

    ok, packer = pcall(require, "packer")
    if ok then
      vim.notify("Installed packer.nvim successfully!", vim.log.levels.INFO)
      return true, packer
    else
      vim.notify("Unable to install packer.nvim!\n" .. "Restart Neovim to retry.", vim.log.levels.ERROR)
      vim.fn.delete(PACKER_INSTALL_PATH, "rf")
      return false, nil
    end
  end

  return ok, packer
end

function M.packer_init(packer)
  packer.init({
    ensure_dependencies = true,
    snapshot = nil,
    -- This is getting loaded manually.
    compile_path = vim.fn.stdpath("config") .. "/lua/compiled.lua",
    auto_clean = true, -- Run packer.clean before running packer.sync()
    compile_on_sync = true, -- Run packer.compile after packer.sync
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "solid" })
      end,
      prompt_border = "solid",
      error_sym = "",
      done_sym = "﫠",
      removed_sym = "",
      moved_sym = "",
      working_sym = "",
    },
    profile = { enable = true },
  })
end

function M.init()
  pcall(vim.api.nvim_command, "packadd packer.nvim")
  local ok, packer = M.ensure_packer()
  if not ok or not packer then
    return
  end
  -- Initialize packer with some settings.
  M.packer_init(packer)

  return packer.startup(function(use)
    -- Basic.
    use({ "wbthomason/packer.nvim", opt = true })
    use({ "lewis6991/impatient.nvim" }) -- faster loading

    -- In this configuration plugins are organized into what I call modules.
    -- Each modules is a bundle of plugins that relate to one specific functionality.
    local modules = { "lang", "editor", "ui" }
    for _, mod in pairs(modules) do
      ---@param x string
      ---@returns function
      local mod_config = function(x)
        local config_function = require(string.format("modules.%s.%s", mod, x)).config
        return config_function
      end

      ---@param x string
      ---@returns function
      local mod_setup = function(x)
        local setup_function = require(string.format("modules.%s.%s", mod, x)).setup
        return setup_function
      end

      require(string.format("modules.%s.spec", mod))(use, mod_config, mod_setup)
    end

    -- Install plugins automatically when packer is bootstrapped.
    if _G.packer_bootstrapped then
      packer.sync()
    end
  end)
end

return M
