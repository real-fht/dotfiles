---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---------------------------------------------------------------------------------

-- Always reload modules, so the skeletons and highlights and colors are always
-- from the latest palette
for mod, _ in pairs(package.loaded) do
    if mod:match("^theme..*") and package.loaded[mod] ~= nil then
        package.loaded[mod] = false
        print("reload")
    end
end

-- Now just reapply as usual.
require("theme").get_theme_data()
require("theme").apply()
