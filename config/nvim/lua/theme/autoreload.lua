---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---------------------------------------------------------------------------------

local theme = require("theme")
-- To avoid spawning one billion watchers.
local instance = nil

local function reload_modules()
    for mod, _ in pairs(package.loaded) do
        if mod:match("^theme..*") then
            -- Only unload the theme modules.
            -- This is because the theme module holds the color data from the files.
            -- And thus we need to unload it to update the colors
            package.loaded[mod] = nil
        end
    end
end

local function setup_watch()
    local base16_watcher = vim.loop.new_fs_event()
    local colors_watcher = vim.loop.new_fs_event()
    local b16_pallete_path = _G.SYSTEM_PALETTE_PATH .. "base16.lua"
    base16_watcher:start(
        b16_pallete_path,
        {},
        vim.schedule_wrap(function(_, _, _)
            vim.defer_fn(function()
                print("w")
                reload_modules()
                -- theme.get_theme_data()
                theme.apply()
            end)
        end)
    )
    -- colors_watcher:start(_G.SYSTEM_PALETTE_PATH .. "colors.lua", {}, function(_, _, _)
    --   print("C change")
    --   reload_modules()
    --   theme.get_theme_data()
    -- end)
end

instance = instance or setup_watch()
return instance
