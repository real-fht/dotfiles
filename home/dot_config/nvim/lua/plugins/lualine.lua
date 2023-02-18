---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.lualine'
---------------------------------------------------------------------------------

local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

M.config = function()
  if not pcall(require, "lualine") then
    return
  end

  local lualine = require("lualine")
  local C = require("theme").colors

  local conditions = {
    ---Checks if a buffer isn't empty
    ---@returns boolean
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    ---Checks for minimum neovim window width
    ---@returns boolean
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    ---Checks that the CWD is a git project
    ---@returns boolean
    check_git_workspace = function()
      local filepath = vim.fn.expand("%:p:h")
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  local config = {
    options = {
      -- Disable sections and component separators
      component_separators = "",
      section_separators = "",
      theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = C.statusline, bg = "none" } },
        inactive = { c = { fg = C.statusline, bg = "none" } },
      },
      diasabled_filetypes = { statusline = { "neo-tree" } },
      ignore_focus = { "neo-tree" },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- These will be filled later
      lualine_c = {},
      lualine_x = {},
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }

  ---Inserts a component in lualine_c at left section
  ---@param component table
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  ---Inserts a component in lualine_x ot right section
  ---@param component table
  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  ---Inserts a component in inactive lualine_c at left section
  ---@param component table
  local function ins_inactive_left(component)
    table.insert(config.inactive_sections.lualine_c, component)
  end

  ---Inserts a component in inactive lualine_x ot right section
  ---@param component table
  local function ins_inactive_right(component)
    table.insert(config.inactive_sections.lualine_x, component)
  end

  ---Gets the appropriate mode color
  ---@returns { fg: string, bg : string }
  local function mode_color()
    -- auto change color according to neovims mode
    local mode_color = {
      n = C.red,
      i = C.green,
      v = C.blue,
      [""] = C.blue,
      V = C.blue,
      c = C.magenta,
      no = C.red,
      s = C.yellow,
      S = C.yellow,
      [""] = C.yellow,
      ic = C.yellow,
      R = C.magenta,
      Rv = C.magenta,
      cv = C.red,
      ce = C.red,
      r = C.cyan,
      rm = C.cyan,
      ["r?"] = C.cyan,
      ["!"] = C.red,
      t = C.red,
    }
    return { fg = mode_color[vim.fn.mode()], gui = "bold" }
  end

  ins_left({
    "mode",
    color = function()
      return mode_color()
    end,
    -- fmt = string.lower,
    padding = { left = 1, right = 2 },
  })

  ins_right({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    padding = { left = 2, right = 0 },
  })

  ins_left({
    "filetype",
    colored = true,
    icon_only = true,
    padding = { left = 2, right = 0 },
    condition = conditions.buffer_not_empty,
  })

  ins_left({
    "filename",
    file_status = true,
    newfile_status = false,
    color = { fg = C.light_grey, bg = "none" },
    condition = conditions.buffer_not_empty,
  })

  ins_right({
    "location",
    color = { fg = C.grey },
    padding = { left = 2, right = 1 },
  })

  ins_right({
    "branch",
    cond = conditions.check_git_workspace,
    icon = "שׂ",
    color = { fg = C.magenta, gui = "bold" },
    padding = { left = 2, right = 2 },
  })

  lualine.setup(config)
end

return M
