---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.neotree'
---------------------------------------------------------------------------------

local M = {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>tf", ":Neotree reveal filesystem<CR>", desc = "Reveal Sidebar (filetree)" },
    { "<leader>tb", ":Neotree reveal buffers<CR>", desc = "Reveal Sidebar (buffers)" },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}

M.config = function()
  local neotree = require("neo-tree")

  neotree.setup({
    -- Neotree's concept revolve around sources. There are builtin ones and
    -- users can create their custom ones too (or just install a plugin)
    sources = { "filesystem", "buffers", "git_status" },

    -- UI setup.
    add_blank_line_at_top = false,
    popup_border_style = "rounded",
    enable_diagnostics = true,
    enable_git_status = true,
    enable_modified_markers = true, -- Show markers for files with unsaved changes.
    hide_root_node = true, -- Hide the root node.
    retain_hidden_root_indent = false,

    -- Behaviour setup.
    close_if_last_window = false,
    default_source = "filesystem",
    enable_refresh_on_write = false, -- no need as we use libuv watchers
    git_status_async = true, -- better performance
    log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
    log_to_file = true, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
    open_files_in_last_window = true, -- false = open files in top left window
    sort_case_insensitive = false,
    use_popups_for_input = false, -- Use vim.ui.input as we use dressing.nvim
    use_default_mappings = true,

    -- Neotree's filetree consists for different sources.
    -- Each source can call for default(builtin) components that are listed here
    -- Here lies the configuration for the builtin comps
    default_component_configs = {
      container = {
        enable_character_fade = true,
        width = "100%",
        right_padding = 0,
      },
      indent = {
        indent_size = 2,
        padding = 1,
        -- indent guides
        with_markers = true,
        indent_marker = "┃",
        last_indent_marker = "┗",
        highlight = "NeoTreeIndentMarker",
        with_expanders = false, -- Not required (unless using nesters)
      },
      icon = {
        folder_closed = "",
        folder_open = "ﱮ",
        folder_empty = "",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "",
        highlight = "NeoTreeFileIcon",
      },
      modified = {
        symbol = "",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false, -- for folders only
        use_git_status_colors = false, -- it's ugly
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "✚", -- NOTE: you can set any of these to an empty string to not show them
          deleted = "✖",
          modified = "",
          renamed = "",
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
        align = "right",
      },
    },
    renderers = {
      directory = {
        { "indent" },
        { "icon" },
        { "current_filter" },
        {
          "container",
          content = {
            { "name", zindex = 10 },
            { "clipboard", zindex = 10 },
            { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
            { "git_status", zindex = 20, align = "right", hide_when_expanded = true },
          },
        },
      },
      file = {
        { "indent" },
        { "icon" },
        {
          "container",
          content = {
            { "name", zindex = 10 },
            { "modified", zindex = 0 },
            { "clipboard", zindex = 10 },
            { "bufnr", zindex = 10 },
            { "diagnostics", zindex = 20, align = "right" },
            { "git_status", zindex = 20, align = "right" },
          },
        },
      },
      message = {
        { "indent", with_markers = false },
        { "name", highlight = "NeoTreeMessage" },
      },
      terminal = {
        { "indent" },
        { "icon" },
        { "name" },
        { "bufnr" },
      },
    },

    window = {
      -- Check https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
      position = "float", -- left, right, top, bottom, float, current
      popup = {
        border = "rounded",
        position = { row = 0, col = 1 },
        size = {
          height = vim.api.nvim_win_get_height(0) - 1,
          width = 33,
        },
      },
      width = 33, -- applies to left and right positions

      auto_expand_width = false, -- Annoying
      -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
      -- You can also create your own commands by providing a function instead of a string.
      mapping_options = { noremap = true, nowait = true },
      mappings = {
        ["<space>"] = "toggle_node",
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "revert_preview",
        ["<C-s>"] = "open_split",
        ["<C-v>"] = "open_vsplit",
        ["<C-t>"] = "open_tabnew",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["Z"] = "expand_all_nodes",
        ["R"] = "refresh",
        ["a"] = { "add", config = { show_path = "relative" } },
        ["A"] = { "add_directory", config = { show_path = "relative" } }, -- also accepts the config.show_path option.
        ["r"] = { "rename", config = { show_path = "relative" } },
        ["d"] = "delete",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path option
        ["m"] = "move", -- takes text input for destination, also accepts the config.show_path option
        ["e"] = "toggle_auto_expand_width",
        ["q"] = "close_window",
        ["?"] = "show_help",
        ["<Tab>"] = "prev_source",
        ["<S-Tab>"] = "next_source",
      },
    },

    filesystem = {
      window = {
        mappings = {
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["f"] = "filter_on_submit",
          ["<C-x>"] = "clear_filter",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          -- ["[g"] = "prev_git_modified",
          -- ["]g"] = "next_git_modified",
        },
      },
      async_directory_scan = "auto", -- Let the plugin decide?
      bind_to_cwd = true, -- Follow Neovim's CWD
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
        show_hidden_count = true, -- Useful to know what im missing
        hide_dotfiles = false, -- Why would you?
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
          "node_modules",
        },
        hide_by_pattern = {
          "*.bak",
          "*.old",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          ".gitignored",
        },
        never_show = { ".DS_Store", "thumbs.db", "yack.lock", "package-lock.json" },
        never_show_by_pattern = { -- uses glob style patterns
          ".null-ls_*", -- null ls artifacts
          "*lock*", -- nobody needs lockfiles
        },
      },
      group_empty_dirs = true,
      search_limit = 50,
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      use_libuv_file_watcher = true, -- faster.
    },

    buffers = {
      bind_to_cwd = true,
      follow_current_file = true, -- This will find and focus the file in the active buffer every time
      -- the current file is changed while the tree is open.
      group_empty_dirs = true, -- when true, empty directories will be grouped together
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["bd"] = "buffer_delete",
        },
      },
    },

    git_status = {
      window = {
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        },
      },
    },
  })

  require("theme").load_skeleton("neotree")
end

return M
