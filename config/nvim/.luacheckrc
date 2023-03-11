---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---------------------------------------------------------------------------------

-- Don't be that quiet, but still don't be super verbose
quiet = 1

-- Colored output is just nicer for the brain to assimilate
color = true

-- Include warning/error codes in case I want to Google it or get more info
codes = true

-- Includes the code ranges where the error/warning was found
ranges = true

-- Don't cache files. Worse performance but better checking.
cache = false

-- Simultaneous jobs.
jobs = 4

-- Don't include 3rdparty repos and software since they will follow their own
-- linting, formatting and everything guideslines
exclude_files = { "3rdparty/", "wibox/", "awesome-old/" }

-- Custom awesomewm std for luacheck.
stds["nvim"] = {
  globals = { "vim" },
}

std = "lua53+nvim"
