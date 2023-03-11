---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---------------------------------------------------------------------------------

local M = {}

_G.SYSTEM_PALETTE_PATH = vim.fn.expand("~/.config/theme/neovim/")

---Loads theme data
function M.get_theme_data()
    if
        -- Only load if the data is valid, duh.
        vim.fn.isdirectory(_G.SYSTEM_PALETTE_PATH) > 0
        and pcall(dofile, _G.SYSTEM_PALETTE_PATH .. "base16.lua")
        and pcall(dofile, _G.SYSTEM_PALETTE_PATH .. "colors.lua")
    then
        -- The following files should have been setup by NixOS and home-manager
        -- to follow the current system theme.
        M.base16 = dofile(_G.SYSTEM_PALETTE_PATH .. "base16.lua")
        M.colors = dofile(_G.SYSTEM_PALETTE_PATH .. "colors.lua")
    end
end

---Loads given skeleton.
---@param skeleton_name string
function M.load_skeleton(skeleton_name)
    local ok, skeleton_highlights = pcall(require, "theme.skeletons." .. skeleton_name)
    if not ok then
        return vim.notify("The skeleton: '" .. skeleton_name .. "' is invalid!", vim.log.levels.WARN)
    end

    -- Loads skeleton's highlight data.
    for highlight_name, highlight_data in pairs(skeleton_highlights) do
        -- Use namespace 0 to apply to every place.
        vim.api.nvim_set_hl(0, highlight_name, highlight_data)
    end
end

---Apply the theme.
function M.apply()
    M.get_theme_data()
    -- Setup Neovim builtin terminal colors.
    vim.g.terminal_color_0 = M.base16.BASE00
    vim.g.terminal_color_1 = M.base16.BASE08
    vim.g.terminal_color_2 = M.base16.BASE0B
    vim.g.terminal_color_3 = M.base16.BASE0A
    vim.g.terminal_color_4 = M.base16.BASE0D
    vim.g.terminal_color_5 = M.base16.BASE0E
    vim.g.terminal_color_7 = M.base16.BASE05
    vim.g.terminal_color_8 = M.base16.BASE01
    vim.g.terminal_color_9 = M.base16.BASE08
    vim.g.terminal_color_10 = M.base16.BASE0B
    vim.g.terminal_color_11 = M.base16.BASE0A
    vim.g.terminal_color_12 = M.base16.BASE0D
    vim.g.terminal_color_13 = M.base16.BASE0E
    vim.g.terminal_color_15 = M.base16.BASE02

    -- Automatically reload theme.
    require("theme.autoreload")

    M.load_skeleton("base")
    M.load_skeleton("syntax")
end

return M
