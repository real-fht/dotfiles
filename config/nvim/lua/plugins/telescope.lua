---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local M = {
    "nvim-telescope/telescope.nvim",
    keys = {
        -- stylua: ignore start
        { "<leader>/", ":Telescope live_grep<CR>", desc = "Live Grep (project)" },
        { "<leader>:", ":Telescope command_history<CR>", desc = "Command(s) History" },
        { "<leader>\\", ":Telescope search_history<CR>", desc = "Search(es) History" },
        { "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Live Grep (File)" },
        { "<leader>f@", ":Telescope treesitter<CR>", desc = "Find Treesitter Node(s)" },
        { "<leader>fO", ":Telescope vim_options<CR>", desc = "Find Vim Option(s)" },
        { "<leader>fb", ":Telescope buffers<CR>", desc = "Find Buffer(s)" },
        { "<leader>ff", ":Telescope find_files<CR>", desc = "Find File(s)" },
        { "<leader>fo", ":Telescope oldfiles<CR>", desc = "Find Old/Recent File(s)" },
        { "<leader>fr", ":Telescope registers<CR>", desc = "Find Register(s)" },
        { "<leader>fS", ":Telescope spell_suggest<CR>", desc = "Find Spell Suggestion(s)" },
        { "z=", ":Telescope spell_suggest<CR>", desc = "Find Spell Suggestion(s)" },
        -- stylua: ignore end
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
}

M.config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
        defaults = {
            sorting_strategy = "ascending", -- sort results from top to bottom
            selection_strategy = "reset", -- reset what is selected after iteration
            scroll_strategy = "limit", -- don't let the cursor scroll indefintely
            layout_strategy = "horizontal", -- see $layout_config
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    width = 0.8,
                    height = 0.90,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                preview_cutoff = 120,
            },
            prompt_prefix = "   ",
            selection_caret = "  ",
            multi_icon = " * ",
            initial_mode = "insert",
            border = true,
            path_display = { "truncate" },
            -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
            mappings = {
                i = {
                    -- Cycle history
                    ["<C-up>"] = actions.cycle_history_prev,
                    ["<C-down>"] = actions.cycle_history_next,
                    -- Exit without passing to normal mode
                    ["<C-c>"] = actions.close,
                },
            },
            history = true, -- Enable keeping a prompt history
            set_env = { COLORTERM = "truecolor" },
        },

        pickers = {
            buffers = { layout_config = { width = 0.4, height = 0.5 }, previewer = false },
            spell_suggest = {
                layout_strategy = "cursor",
                layout_config = { width = 0.3, height = 0.4 },
                previewer = false,
                border = false,
                title = " ",
            },
        },
    })

    ---@param extension string
    local load_telescope_extension = function(extension)
        local ok, _ = pcall(require("telescope").load_extension, extension)
        if not ok then
            vim.notify("Unable to load Telescope extension: '" .. (extension or "NIL") .. "'")
        end
    end

    require("theme").load_skeleton("telescope")
    load_telescope_extension("fzf")
end

return M
