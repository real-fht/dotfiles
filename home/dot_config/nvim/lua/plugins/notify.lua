---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.notify'
---------------------------------------------------------------------------------

local M = {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
}

M.config = function()
  local notify = require("notify")

  -- Override vim.notify so we can use nvim-notify with it.
  vim.notify = notify

  notify.setup({
    timeout = 4500, -- in milliseconds.
    render = "custom", -- see lua/notify/render/custom.lua
    fps = 30, -- smoooooth
    fade_in_slide_out = true,
  })

  require("theme").load_skeleton("notify")
end

return M
