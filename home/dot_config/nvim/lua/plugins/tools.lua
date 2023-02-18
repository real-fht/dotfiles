---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.tools'
---------------------------------------------------------------------------------

return {
  -- Very useful plugin, I use it on a daily basis.
  { "junegunn/vim-easy-align", cmd = "EasyAlign" },

  {
    -- Rarely used, but still useful sometimes
    "mbbill/undotree",
    keys = {
      {
        "<leader>u",
        ":UndotreeToggle<CR>",
        desc = "Toggle Untodree",
      },
    },
  },

  {
    "famiu/bufdelete.nvim",
    keys = {
      {
        "<leader>x",
        ":Bdelete!<CR>",
        desc = "Close buffer ",
      },
    },
  },

  {
    "RRethy/vim-hexokinase",
    config = function()
      vim.g.Hexokinase_optInPatterns = {
        "full_hex",
        "triple_hex",
        "rgb",
        "rgba",
        "hsl",
        "hsla",
        "colour_names",
      }

      -- Cleaner than signcolumn.
      vim.g.Hexokinase_highlighters = { "virtual" }
    end,
    build = "nix-shell -p go --run 'make hexokinase'",
    cmd = { "HexokinaseToggle", "HexokinaseTurnOn", "HexokinaseTurnOff" },
  },
}
