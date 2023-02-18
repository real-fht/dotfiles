---@diagnostic disable
-- vim: ft=lua tw=80

stds.nvim = {
  globals = {
    "lvim",
    "reload",
    vim = { fields = { "g" } },
    "TERMINAL",
    "MUtils",
    os = { fields = { "capture" } },
  },
  read_globals = {
    "jit",
    "os",
    "vim",
  },
}
std = "lua51+nvim"

files["tests/*_spec.lua"].std = "lua51+nvim+busted"

-- Don't report unused self arguments of methods.
self = false

-- Rerun tests only if their modification time changed.
cache = true

ignore = {
  "631", -- max_line_length
  "212/_.*", -- unused argument, for vars with "_" prefix
}
