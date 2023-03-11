---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---------------------------------------------------------------------------------

-- Load impatient.nvim as soon as possible for module caching.
if pcall(require, "impatient") then
    require("impatient")
    require("impatient").enable_profile()
end

-- Basic neovim configuration.
require("core")
