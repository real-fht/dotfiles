---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.comment'
---------------------------------------------------------------------------------

local M = {
  "numToStr/Comment.nvim",
  keys = {
    { "gc", mode = { "n", "v", "x" } },
    { "gb", mode = { "n", "v", "x" } },
  },
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
}

M.config = function()
  local comment = require("Comment")

  comment.setup({
    padding = true,
    sticky = true, -- just.
    ignore = nil, -- annoying.
    toggler = { line = "gcc", block = "gcb" },
    opleader = { line = "gc", block = "gb" },
    extra = { above = "gcO", below = "gco", eol = "gcA" },
    mappings = { basic = true, extra = true },
    pre_hook = function(...)
      local supported_ft = {
        "javascript",
        "typescript",
        "typescriptreact",
        "css",
        "scss",
        "php",
        "html",
        "svelte",
        "vue",
        "astro",
        "handlebars",
        "glimmer",
        "graphql",
        "lua",
      }

      -- Only use ts-context-comment-string for supported filetypes.
      if vim.tbl_contains(supported_ft, vim.bo.filetype) then
        return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(...)
      else
        return nil
      end
    end,
  })
end

return M
