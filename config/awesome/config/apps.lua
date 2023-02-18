---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'config.apps'
---------------------------------------------------------------------------------

-- What default apps you want to use (on a large scale)
local apps = {}

-- Default terminal emulator, spawned using Mod+Return.
-- It's also used when opening terminal-only programs from the launch menu.
apps.terminal = "kitty"

-- What is your preferred editor, spawned using Mod+Shift+e.
-- Good canditates for here would be GNU/Emacs or Neovide. A safe fallback would
-- be: apps.terminal ..  ' -e ' .. os.getenv("EDITOR")
apps.editor = "neovide"

-- What is your preferred GUI file manager, spawned using Mod+e (windows-like)
apps.file_manager = "pcmanfm"

-- What is your preferred web browser, spawned using Mod+Shift+b
apps.web_browser = "qutebrowser" -- nyxt

-- What is your preferred screenshot programs.
apps.screenshot_tool = "flameshot gui"

return apps
