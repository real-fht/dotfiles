---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

-- Overriding the vim.keymap.set function to enforce default settings.
-- Yes, I do know it's a bad idea to override core functions, but there isn't
-- a builtin way to set default options.
vim.keymap.set_backup = vim.keymap.set
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table|nil
function vim.keymap.set(mode, lhs, rhs, opts) ---@diagnostic disable-line
    opts = opts or {}
    opts.silent = opts.silent ~= nil and opts.silent or true -- Why isn't this a default?
    vim.keymap.set_backup(mode, lhs, rhs, opts)
end

local set_keymap = vim.keymap.set

-- Window navigation made easier.
set_keymap("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
set_keymap("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
set_keymap("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
set_keymap("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- Window resizing made easier too
set_keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Window Resize Left" })
set_keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Window Resize Down" })
set_keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Window Resize Up" })
set_keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Window Resize Right" })

-- Terminal window navigation
set_keymap("t", "<C-x>", "<C-\\><C-N><Esc>", { desc = "Exit Terminal insert" })
set_keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Window Left" })
set_keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Window Down" })
set_keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Window Up" })
set_keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Window Right" })

-- Various buffer actions.
set_keymap("n", "<leader>n", ":enew<CR>", { desc = "New Buffer" })
set_keymap("i", "<C-t>", "<cmd>enew<BAR>startinsert<CR>", { desc = "New Buffer" })

local function close()
    -- Returns `true` if there's only one buffer left.
    local is_last_buffer = function()
        return #vim.fn.getbufinfo({ buflisted = 1 }) == 1
    end

    -- The current buffer filetype and buffer type.
    local filetype, buftype = vim.bo.filetype, vim.bo.buftype
    -- Bufdelete command provided by bufdelete.nvim.
    local bufdelete_cmd = "Bdelete"

    local cmd = ((filetype == "help" or buftype == "nofile" or is_last_buffer()) and "q")
        or (buftype == "terminal" and bufdelete_cmd .. "!")
        or bufdelete_cmd

    vim.cmd(cmd)
end

-- Custom bufdelete function that doesn't mess up window layout.
set_keymap("n", "<leader>x", close, { desc = "Close Buffer" })
set_keymap("i", "<C-x>", close, { desc = "Close Buffer" })

-- Easier splits
set_keymap("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical Split" })
set_keymap("n", "<leader>-", ":split<CR>", { desc = "Horizontal Split" })

-- Toggling some random stuff.
-- set_keymap("n", "<leader>tn", ":set number!<CR>", { desc = "Toggle Numberline" })
-- set_keymap("n", "<leader>tN", ":set relativenumber!<CR>", { desc = "Toggle Relative Numberline" })
-- set_keymap("n", "<leader>ts", ":set spell!<CR>", { desc = "Toggle Spellcheck" })
-- set_keymap("n", "<leader>tS", function()
--     local laststatus = vim.opt.laststatus:get()
--     vim.opt.laststatus = laststatus == 3 and 0 or 3
-- end)

-- Stop matching for patterns
set_keymap("n", "<Esc>", ":nohlsearch<CR>")

-- Allow moving through wrapped lines without using g{j,k}
set_keymap("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
set_keymap("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
set_keymap("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
set_keymap("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- Easier indenting.
set_keymap("n", ">", ">>", { desc = "Indent to the Left" })
set_keymap("n", "<", "<<", { desc = "Indent to the Right" })
set_keymap({ "v", "x" }, "<", "<gv", { desc = "Indent to the Left" })
set_keymap({ "v", "x" }, ">", ">gv", { desc = "Indent to the Right" })

-- Don't put deleted text from x into clipboard.
set_keymap("n", "x", '"_x', { noremap = false })

-- Move lines or something
-- set_keymap("v", "J", ":m >+1<CR>gv=gv", { noremap = true })
-- set_keymap("v", "K", ":m <-2<CR>gv=gv", { noremap = true })

-- Just quit it all.
set_keymap("n", "<leader>Q", ":quitall!<CR>", { desc = "Quit Neovim" })

-- Keep the cursor centered
set_keymap("n", "<C-d>", "<C-d>zz")
set_keymap("n", "<C-u>", "<C-u>zz")
set_keymap("n", "n", "nzzzv")
set_keymap("n", "N", "Nzzzv")
