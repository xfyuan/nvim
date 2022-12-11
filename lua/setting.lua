local options = {
  cmdheight      = 1,                       --- Give more space for displaying messages
  completeopt    = "menu,menuone,noselect", --- Better autocompletion
  emoji          = false,                   --- Fix emoji display
  -- ignorecase     = true,                    --- Needed for smartcase
  -- smartcase      = true,                    --- Uses case in search
  -- lazyredraw     = true,                    --- Makes macros faster & prevent errors in complicated mappings
  mouse          = "a",                     --- Enable mouse
  number         = true,                    --- Shows current line number
  scrolloff      = 4,                       --- Always keep space when scrolling to bottom/top edge
  showtabline    = 2,                       --- Always show tabs
  signcolumn     = "yes:2",                 --- Add extra sign column next to line number
  splitbelow     = true,                    --- Horizal splits will automatically be to the bottom
  splitright     = true,                    --- Vertical splits will automatically be to the right
  termguicolors  = true,                    --- Correct terminal colors
  timeoutlen     = 500,                     --- Faster completion (cannot be lower than 200 because then commenting doesn't work)
  updatetime     = 250,                     --- Faster completion
  viminfo        = "'1000",                 --- Increase the size of file history
  wildignore     = "*node_modules/**",      --- Don't search inside Node.js modules (works for gutentag)
  -- cursorline     = true,                    --- Highlight of current line
  -- laststatus     = 3,                       --- Have a global statusline at the bottom instead of one for each window
  -- pumheight      = 10,                      --- Max num of items in completion menu
  -- relativenumber = false,                   --- Enables relative number
  -- wrap           = true,                    --- Display long lines as wrap line
  ruler          = false,
  hidden         = true,
  cul            = true,
  numberwidth    = 4,
  sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal',

  -- Backup
  swapfile       = false,                   --- Swap not needed
  backup         = false,                   --- Recommended by coc
  writebackup    = false,                   --- Not needed
  autoread       = true,

  -- Undo
  undofile       = true,                    --- Sets undo to file
  undolevels     = 1000,
  undoreload     = 1000,
  undodir        = vim.fn.stdpath('config') .. '/undo',

  -- Fold
  foldenable     = true,                    --- Use spaces instead of tabs
  foldlevel      = 99,                      --- Using ufo provider need a large value
  foldlevelstart = 99,                      --- Expand all folds by default
  -- foldmethod     = 'indent',                --- Use spaces instead of tabs
  foldcolumn     = "0",
  -- foldnestmax    = 0,

  -- Indentation
  expandtab      = true,                    --- Use spaces instead of tabs
  smartindent    = true,                    --- Makes indenting smart
  smarttab       = true,                    --- Makes tabbing smarter will realize you have 2 vs 4
  softtabstop    = 2,                       --- Insert 2 spaces for a tab
  shiftwidth     = 2,                       --- Change a number of space characeters inseted for indentation
  tabstop        = 2,                       --- Insert 2 spaces for a tab

  -- Neovim defaults
  autoindent     = true,                    --- Good auto indent
  backspace      = "indent,eol,start",      --- Making sure backspace works
  conceallevel   = 0,                       --- Show `` in markdown files
  showmode       = false,                   --- Don't show things like -- INSERT -- anymore
  -- errorbells     = false,                   --- Disables sound effect for errors
  -- incsearch      = true,                    --- Start searching before pressing enter
  -- encoding       = "utf-8",                 --- The encoding displayed
  -- fileencoding   = "utf-8",                 --- The encoding written to file
}

local globals = {
  mapleader                   = ' ',        --- Map leader key to SPC
  speeddating_no_mappings     = 1,          --- Disable default mappings for speeddating
}

vim.opt.shortmess:append('c');
vim.opt.formatoptions:remove('c');
vim.opt.formatoptions:remove('r');
vim.opt.formatoptions:remove('o');
vim.opt.fillchars:append('stl: ');
vim.opt.fillchars:append('eob: ');
vim.opt.fillchars:append('fold: ');
vim.opt.fillchars:append('foldopen: ');
vim.opt.fillchars:append('foldsep: ');
vim.opt.fillchars:append('foldclose:');

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end

-- ================= Useful ================= --
local cmd = vim.cmd

cmd("nnoremap ; :")
cmd("nnoremap : ;")

-- remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\s\+$//e]])
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])
