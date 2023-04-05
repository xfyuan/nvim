vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- opt.autowrite = true -- Enable auto write
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.guifont = "JetBrainsMono Nerd Font Mono:h18"
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
-- opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes:2" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartindent = true -- Insert indents automatically
opt.smarttab = true -- Insert tabs automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 1000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Enable line wrap

-- Backup
opt.swapfile = false --- Swap not needed
opt.backup = false --- Recommended by coc
opt.writebackup = false --- Not needed
opt.autoread = true

-- Fold
opt.foldenable = true --- Use spaces instead of tabs
opt.foldlevel = 99 --- Using ufo provider need a large value
opt.foldlevelstart = 99 --- Expand all folds by default
opt.foldcolumn = "0"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- ================= Useful ================= --
local cmd = vim.cmd

cmd("nnoremap ; :")
cmd("nnoremap : ;")

-- remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\s\+$//e]])
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])
