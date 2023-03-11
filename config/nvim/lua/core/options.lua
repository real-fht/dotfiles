---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

---@diagnostic disable

-- You can check `:options` and `:help 'option_name'` for better info about what
-- is set in this file.
local O = vim.opt

-- Disable Vi-Like compatibility. Who needs this???
-- Also this breaks basically every plugin that's used here.
O.cp, O.cpo = false, ""

-- Better path, directory and file searching
-- Also better behaviour changing for directories.
O.cdhome = true -- `:cd` alone takes you to ~ or $HOME
O.path:append("**") -- search recursively in the current working directory
O.cdpath:append("**") -- cd recursively in the current working directory
O.autochdir = false -- Don't follow the buffer directory

-- Better search behaviour defaults.
O.incsearch = true -- search while i'm typing patterns
O.hlsearch = true -- highlight search matches
O.ignorecase = true -- case insensitive searching
O.smartcase = true -- unless there's a capital in the pattern

-- Visual settings, how neovim should look.
O.background = "dark" -- join the dark side..
O.wrap = false -- I hate line wrapping.
O.scrolloff = 8 -- Always keep atleast 8 lines up and down the cursor
O.sidescrolloff = 12 -- Same as ^ but horizontally
O.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "", stl = " ", stlnc = "_" }
O.nu, O.rnu, O.nuw = false, false, 4 -- Enable the numberline
O.cursorline = true -- Pretty useful
O.scl, O.stal = "yes:1", 1 -- Always show the signcolumn and never show the  tabline
O.laststatus = 3 -- use a global statusline
O.termguicolors = true -- Required for colorschemes
O.pumheight = 12 -- anything higher will be annoying
O.guifont = "monospace:h11"
O.foldcolumn = "0" -- see folds!
O.smd = false -- handled by the statusline
O.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block" -- always keep it as a block!

-- Some behvaiour settings for neovim
O.timeoutlen = 500 -- faster keymaps
O.mouse = "a" -- Enable mouse support
O.scroll = 12 -- Scroll 12 lines using <C-d> and <C-u>
O.undofile = true -- Enable persistent undo
O.errorbells = false -- ANNOYING
local tab_size = 4
O.ts, O.sts, O.sw = tab_size, tab_size, tab_size
O.expandtab = true -- Use soft tabs (not literal \t)
O.ai, O.si = true, true -- auto and smart indenting
O.exrc = true -- Load a .vimrc/.exrc from cwd if it exists
O.hidden = true -- Don't unload buffers that aren't displayed
O.fdls = 9999 -- don't fold anything automatically
O.splitright, O.splitbelow = true, true

-- Shell setup.
-- Based on fish-shell/fish-shell#7004, using fish in Neovim causes horrible
-- performance, so if the user's shell is somehow fish (it's bad), change it
-- to POSIX sh.
O.shell = (function()
    local shell = os.getenv("SHELL")
    return shell:match("fish") and "/bin/sh" or shell
end)()

-- Clipboard setup.
if vim.fn.has("clipboard") > 0 then
    -- Use system clipboard is provider is available
    -- Also use :checkhealth to check if a clipboard provider is available
    O.clipboard:append({ "unnamed", "unnamedplus" })
end

-- Runtimepath setup.
-- I do this only for 'app-vim/gentoo-syntax', for ebuild editing, make.conf
-- and other gentoo-specific configuration.
-- O.runtimepath:append("/usr/share/vim/vimfiles")

-- Go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
O.whichwrap:append([[<>[]hl]])

-- Disable nvim intro, aswell as completion messages
O.shortmess:append("sIc")
