---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---------------------------------------------------------------------------------

---Disables Neovim's builtin plugins (bundled in $VIMRUNTIME)
local function disable_builtin_plugins()
    local builtin_plugins = { "gzip", "tar", "tar", "zip", "zip", "netrw", "2html", "logiPat", "rrhelper" }
    for _, builtin_plugin in pairs(builtin_plugins) do
        vim.g["loaded_" .. builtin_plugin] = 1
        vim.g["loaded_" .. builtin_plugin .. "Plugin"] = 1
    end
end

---Disable checking for language providers.
local function disable_checking_providers()
    local providers = { "python", "node", "ruby", "perl" }
    for _, provider in pairs(providers) do
        vim.g["loaded_" .. provider .. "_provider"] = 0
    end
end

local function mapleader(leader_key)
    vim.g.mapleader = leader_key
    vim.g.maplocalleader = leader_key
end

-- Generalities that are just common everywhere.
disable_builtin_plugins()
disable_checking_providers()
mapleader(" ")

-- Personal configuration initialization.
require("core.options")
require("core.keymaps")
require("core.autocmd")
require("core.plugins")

-- NOTE: You have to set the theme after setting options since tgc hasn't been
-- set yet, making the theme break.
require("theme").apply()
