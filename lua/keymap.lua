local cmd = vim.cmd
-- local g = vim.g

-- local opt = {}
local opt = {silent = true}

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them
--[[ remove this line

map("n", "dd", [=[ "_dd ]=], opt)
map("v", "dd", [=[ "_dd ]=], opt)
map("v", "x", [=[ "_x ]=], opt)

 this line too ]]
--

-- ================= Core Powerfull Mapping ================= -- {{{

cmd("inoremap jj <Esc>")
cmd("tnoremap jj <C-\\><C-n>")

-- general --
cmd("nnoremap <Enter> o<ESC>") -- Insert New Line quickly
-- cmd("nnoremap <BS> <c-^>") -- Switch between 2 buffers
cmd("nnoremap <leader><leader> <c-^>") -- Switch between 2 buffers
cmd('nnoremap <leader>p "*p') -- Paste content from OS's clipboard
cmd('vnoremap <leader>y "*y') -- Yank content in OS's clipboard

-- TABs --
-- map("n", "<S-t>", [[<Cmd>tabnew<CR>]], opt) -- new tab
-- map("n", "<S-x>", [[<Cmd>bdelete<CR>]], opt) -- close tab
-- map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
-- map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
map("n", "<left>", [[<Cmd>tabprevious<CR>]], opt)
map("n", "<right>", [[<Cmd>tabnext<CR>]], opt)
map("n", "<down>", [[<Cmd>tabclose<CR>]], opt)

-- move between windows
map("n", "<C-j>", "<C-W>j", opt)
map("n", "<C-k>", "<C-W>k", opt)
map("n", "<C-h>", "<C-W>h", opt)
map("n", "<C-l>", "<C-W>l", opt)

-- move between lines
map("n", "0", "^", opt)
map("n", "j", "gj", opt)
map("n", "k", "gk", opt)

map("n", "<TAB>", "%", opt)
map("i", "<C-a>", "<C-o>^", opt)
map("i", "<C-e>", "<END>", opt)

-- Go to beginning of line. Goes to previous line if repeated
map("n", "H", "getpos('.')[2] == 1 ? 'k' : '^'", {expr = true})
-- Go to end of line. Goes to next line if repeated
map("n", "L", "len(getline('.')) == 0 || len(getline('.')) == getpos('.')[2] ? 'jg_' : 'g_'", {expr = true})

-- quick split window
map("n", "_", [[<Cmd>sp<CR>]], opt)
map("n", "<bar>", [[<Cmd>vsp<CR>]], opt)

-- yank and paste
map("n", "Y", "y$", opt) -- Yanking to the end of line
map("n", "p", "p`[", opt) -- Paste yank after, keep cursor position
map("n", "P", "P`[", opt) -- Paste yank before, keep cursor position

-- input shortcuts
map("i", "uu", "_", opt)
map("i", "hh", "-", opt)
map("i", "ii", "=", opt)
map("i", "kk", "->", opt)
map("i", "jk", "=>", opt)
map("i", "ii", "=", opt)
map("i", "vv", "<bar>>", opt)

-- OPEN TERMINALS --
-- map("n", "<C-l>", [[<Cmd>vnew term://bash <CR>]], opt) -- term over right
-- map("n", "<C-x>", [[<Cmd> split term://bash | resize 10 <CR>]], opt) --  term bottom
-- map("n", "<C-t>t", [[<Cmd> tabnew | term <CR>]], opt) -- term newtab

-- copy whole file content
-- map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- toggle numbers
-- map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)

-- }}}

-- ================= Plugins Mapping ================= -- {{{
map("n", "<C-p>", [[<Cmd>GitFiles<CR>]], opt)

-- map("n", "<C-e>", [[<Cmd>CtrlSF<CR>]], opt)

map("n", "<leader>ss", ":lua require('spectre').open()<cr>", opt)
map("n", "<leader>sw", "viw:lua require('spectre').open_visual()<cr>", opt)
map("v", "<leader>sw", ":lua require('spectre').open_visual()<cr>", opt)
map("n", "<leader>sf", "viw:lua require('spectre').open_file_search()<cr>", opt)

cmd([[nmap <C-]> <Plug>(fzf_tags)]])

-- }}}

-- ================= Compe and VSnip Mapping ================= -- {{{
-- vsnip mapping
cmd([[imap <expr> <C-l> vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"]])
cmd([[imap <expr> <C-k> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)"      : "<C-k>"]])
-- }}}

-- ================= Whichkey Mapping ================= -- {{{
require("which-key").setup {}

local wk = require("which-key")

wk.register({
  -- ['<leader>'] = {'<cmd>GitFiles<cr>', 'find git files'},
  -- ['1'] = {':normal "lyy"lpwv$r=^"lyyk"lP<cr>', 'mark ======'},
  q = {':q!<cr>', 'quit without saving'},
  k = {'<Plug>DashSearch', 'search word in Dash'}, -- dash.vim plugin
  -- o = {'<cmd>ToggleTerm<cr>', 'toggle terminal window'}, -- toggleterm.nvim plugin
  o = {'<cmd>AerialToggle<cr>', 'toggle code outline window'}, -- aerial.nvim plugin
  d = {
    name = 'db, buffer',
    -- bufdelete.nvim plugin
    d = {'<cmd>Bdelete<cr>', 'delete buffer'},
    -- vim-dadbod plugin
    u = {'<cmd>DBUI<cr>', 'open db ui'},
    -- l = {'<Plug>(DBExeLine)', 'run line as query'},
  },
  f = {
    name = "fzf",
    -- fzf.vim plugin
    j = {'<cmd>GitFiles<cr>', 'find git files'},
    f = {'<cmd>Files<cr>', 'find files'},
    b = {'<cmd>Buffers<cr>', 'find buffers'},
    o = {'<cmd>History<cr>', 'find old history'},
    t = {'<cmd>FocusToggle<cr>', 'Toggle focus.nvim'},
  },
  g = {
    name = 'git',
    -- nvim-telescope plugin
    -- l = {'<cmd>Telescope git_status<cr>', 'changed files'},
    b = {'<cmd>Telescope git_branches<cr>', 'list branches'},
    -- vim-fugitive plugin
    g = {'<cmd>Git blame<cr>', 'blame'},
    s = {'<cmd>Git<cr>', 'status'},
    l = {'<cmd>GFiles?<cr>', 'changed files'},
    d = {'<cmd>Gdiff<cr>', 'diff'},
    r = {'<cmd>Gread<cr>', 'read'},
    w = {'<cmd>Gwrite<cr>', 'write'},
    p = {'<cmd>Gpush<cr>', 'push'},
    c = {'<cmd>Gcommit -v<cr>', 'commit'},
    -- vim-rhubarb plugin
    -- b = {'<cmd>Gbrowser<cr>', 'browse github'},
    -- gv.vim plugin
    h = {'<cmd>GV!<cr>', 'list only current file commits'},
  },
  h = {
    name = "telescope",
    -- nvim-telescope plugin
    h = {'<cmd>Telescope git_files<cr>', 'find git files'},
    f = {'<cmd>Telescope find_files<cr>', 'find files'},
    b = {'<cmd>Telescope buffers<cr>', 'find buffers'},
    d = {'<cmd>Telescope commands<cr>', 'search commands'},
    o = {'<cmd>Telescope oldfiles<cr>', 'opened files history'},
    r = {'<cmd>Telescope registers<cr>', 'vim registers'},
    g = {'<cmd>Telescope grep_string<cr>', 'grep word under cursor'},
    w = {'<cmd>Telescope live_grep<cr>', 'grep string'},
  },
  l = {
    name = 'LSP',
    -- lspsaga.nvim plugin
    l = {"<cmd>Telescope lsp_definitions<cr>", 'list word definition and reference'},
    s = {"<cmd>Telescope lsp_document_symbols<cr>", 'list document symbols'},
    k = {'<cmd>lua vim.lsp.buf.hover()<cr>', 'show hover doc'},
    -- p = {"<cmd>lua require'lspsaga.provider'.preview_definition()<cr>", 'preview definition'},
    r = {"<cmd>lua vim.lsp.buf.rename()<CR>", 'rename'},
    a = {"<cmd>Telescope lsp_code_actions<CR>", 'code action'},
    -- s = {"<cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>", 'show signature help'},
    -- d = {"<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<cr>", 'show diagnostic'},
    -- [';'] = {"<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<cr>", 'jump previous diagnostic'},
    -- [','] = {"<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<cr>", 'jump previous diagnostic'},
    -- nvim-lspfuzzy plugin
    -- e = {"<cmd>lua vim.lsp.buf.definition()<cr>", 'fzf list definition'},
    n = {"<cmd>lua vim.lsp.buf.references()<cr>", 'fzf list references'},
    o = {"<cmd>SymbolsOutline<cr>", 'toggle symbols-outline window'},
    -- b = {"<cmd>lua vim.lsp.buf.document_symbol()<CR>", 'fzf list symbols'},
    -- v = {
    --   name = 'vista',
    --   -- vista.vim plugin
    --   v = {'<cmd>Vista!!<cr>', 'toggle vista window'},
    --   -- symbols-outline.nvim plugin
    --   s = {'<cmd>SymbolsOutline<cr>', 'toggle symbols-outline window'},
    -- },
    t = {
      name = 'Trouble',
      -- lsp-trouble.nvim plugin
      t = {"<cmd>LspTroubleToggle lsp_document_diagnostics<cr>", 'list troubles diagnostic'},
      r = {"<cmd>LspTroubleToggle lsp_references<cr>", 'list troubles reference'},
    },
    -- o = {
    --   name = 'LSP original function',
    --   d = {'<cmd>lua vim.lsp.buf.definition()<cr>', 'definition'},
    --   k = {'<cmd>lua vim.lsp.buf.hover()<cr>', 'hover doc'},
    --   n = {'<cmd>lua vim.lsp.buf.references()<cr>', 'references'},
    --   r = {'<cmd>lua vim.lsp.buf.rename()<CR>', 'rename'},
    --   i = {'<cmd>lua vim.lsp.buf.implementation()<cr>', 'implementation'},
    --   t = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', 'type definition'},
    -- },
  },
  m = {
    name = 'hop(easymotion)',
    -- hop.nvim plugin
    m = {'<cmd>HopWord<cr>', 'word'},
    l = {'<cmd>HopLine<cr>', 'line'},
    p = {'<cmd>HopPattern<cr>', 'pattern'},
    -- vim-prettier plugin
    -- t = {'<Plug>(Prettier)', 'prettier format current buffer'},
  },
  r = {
    name = 'ripgrep',
    -- fzf.vim plugin
    g = {':Rg <c-r><c-w><cr>', 'search cursor word'},
  },
  t = {
    name = 'test',
    -- vim-test plugin
    t = {'<cmd>TestNearest<cr>', 'nearest case'},
    l = {'<cmd>TestLast<cr>', 'last case'},
    f = {'<cmd>TestFile<cr>', 'whole file'},
  },
  w = {
    name = 'translator window',
    -- vim-test plugin
    -- w = {'<cmd>MacDictPopup<cr>', 'search cursor word in macOS distionary'},
    -- d = {'<cmd>MacDictWord<cr>', 'search in macOS distionary and show in quickfix'},
    l = {'<Plug>TranslateW', 'Translate word online'},
  },
}, { prefix = "<leader>" })
-- }}}
