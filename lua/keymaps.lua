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
map("i", "vv", "<bar>>", opt)

-- OPEN TERMINALS --
-- map("n", "<C-l>", [[<Cmd>vnew term://bash <CR>]], opt) -- term over right
-- map("n", "<C-x>", [[<Cmd> split term://bash | resize 10 <CR>]], opt) --  term bottom
-- map("n", "<C-t>t", [[<Cmd> tabnew | term <CR>]], opt) -- term newtab

-- copy whole file content
-- map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- toggle numbers
-- map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)

-- toggle diff buffers
map("n", "<leader>df", "&diff ? ':windo diffoff<cr>' : ':windo diffthis<cr>'", {expr = true})
-- }}}

-- ================= Plugins Mapping ================= -- {{{
-- map("n", "<C-p>", [[<Cmd>GitFiles<CR>]], opt)
map("n", "<C-p>", [[<Cmd>Telescope git_files<CR>]], opt)

-- map("n", "<C-e>", [[<Cmd>CtrlSF<CR>]], opt)

map("n", "<leader>sR", ":lua require('spectre').open()<cr>", opt)
map("n", "<leader>sw", "viw:lua require('spectre').open_visual()<cr>", opt)
map("v", "<leader>sw", ":lua require('spectre').open_visual()<cr>", opt)
map("n", "<leader>sf", "viw:lua require('spectre').open_file_search()<cr>", opt)

cmd([[nmap <C-]> <Plug>(fzf_tags)]])

-- }}}

-- ================= Whichkey Mapping ================= -- {{{
require("which-key").setup {
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "i", "j", "k", "h", "u", "v" },
    v = { "j", "k" },
  },
}

local wk = require("which-key")

wk.register({
  -- ['<leader>'] = {'<cmd>GitFiles<cr>', 'find git files'},
  -- ['1'] = {':normal "lyy"lpwv$r=^"lyyk"lP<cr>', 'mark ======'},
  q = {':q!<cr>', 'quit without saving'},
  Q = {':qa!<cr>', 'quit all windows without saving'},
  k = {'<Plug>DashSearch', 'search word in Dash'}, -- dash.vim plugin
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
    name = "fuzzy finder",
    -- fzf.vim
    -- j = {'<cmd>GitFiles<cr>', 'find git files'},
    -- f = {'<cmd>Files<cr>', 'find files'},
    -- b = {'<cmd>Buffers<cr>', 'find buffers'},
    -- o = {'<cmd>History<cr>', 'find old history'},
    -- telescope
    o = {'<cmd>Telescope git_files<cr>', 'find git files'},
    f = {'<cmd>Telescope find_files<cr>', 'find files'},
    b = {'<cmd>Telescope buffers<cr>', 'find buffers'},
    h = {'<cmd>Telescope oldfiles<cr>', 'opened files history'},
    s = {'<cmd>Telescope luasnip<cr>', 'search snippet'},
  },
  g = {
    name = 'git',
    -- telescope
    l = {'<cmd>Telescope git_status<cr>', 'changed files'},
    -- vim-fugitive plugin
    g = {'<cmd>Git blame<cr>', 'blame'},
    s = {'<cmd>Git<cr>', 'status'},
    -- l = {'<cmd>GFiles?<cr>', 'changed files'},
    d = {'<cmd>Gdiff<cr>', 'diff'},
    r = {'<cmd>Gread<cr>', 'read'},
    -- w = {'<cmd>Gwrite<cr>', 'write'},
    p = {'<cmd>Git push<cr>', 'push'},
    c = {'<cmd>Gcommit -v<cr>', 'commit'},
    -- gitsigns plugin
    j = {"<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk"},
    k = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk"},
    a = {"<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk"},
    u = {"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk"},
    -- vim-rhubarb plugin
    -- b = {'<cmd>Gbrowser<cr>', 'browse github'},
    -- gv.vim plugin
    h = {'<cmd>GV!<cr>', 'list only current file commits'},
  },
  j = {
    name = 'hop(easymotion)',
    -- hop.nvim plugin
    j = {'<cmd>HopWord<cr>', 'word'},
    c = {'<cmd>HopChar2<cr>', '2 char'},
    l = {'<cmd>HopLine<cr>', 'line'},
    p = {'<cmd>HopPattern<cr>', 'pattern'},
    -- vim-prettier plugin
    -- t = {'<Plug>(Prettier)', 'prettier format current buffer'},
  },
  l = {
    name = 'lsp',
    j = {"<cmd>vsplit <bar> Telescope lsp_definitions<cr>", 'list word definition and reference'},
    s = {"<cmd>Telescope lsp_document_symbols<cr>", 'list document symbols'},
    k = {'<cmd>lua vim.lsp.buf.hover()<cr>', 'show hover doc'},
    r = {"<cmd>Telescope lsp_references<CR>", 'list references'},
    R = {"<cmd>lua vim.lsp.buf.rename()<CR>", 'rename'},
    a = {"<cmd>Telescope lsp_code_actions<CR>", 'code action'},
    i = {'<cmd>TSLspImportAll<CR>', 'ts import all'},
    o = {'<cmd>TSLspOrganize<CR>', 'ts organize imports'},
    q = {'<cmd>TSLspFixCurrent<CR>', 'ts quick fix' },
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
  s = {
    name = "search/session",
    c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
    C = {"<cmd>Telescope commands<cr>", "Commands"},
    h = {"<cmd>Telescope help_tags<cr>", "Find Help"},
    H = {"<cmd>Telescope heading<cr>", "Find Header"},
    m = {"<cmd>Telescope marks<cr>", "Find Mark"},
    M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
    r = {"<cmd>Telescope registers<cr>", "Registers"},
    t = {"<cmd>Telescope live_grep<cr>", "Text"},
    s = {"<cmd>Telescope grep_string<cr>", "Text under cursor"},
    S = {"<cmd>Telescope symbols<cr>", "Search symbols"},
    k = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
    P = {
        "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview"
    },
    a = {"<cmd>SaveSession<cr>", "add auto session"},
    l = {"<cmd>RestoreSession<cr>", "load auto session"},
    d = {"<cmd>DeleteSession<cr>", "delete auto session"},
    f = {'<cmd>SearchSession<cr>', 'search auto session'},
  },
  t = {
    name = 'test & trouble',
    -- vim-test plugin
    t = {'<cmd>TestNearest<cr>', 'Test nearest case'},
    l = {'<cmd>TestLast<cr>', 'Test last case'},
    f = {'<cmd>TestFile<cr>', 'Test whole file'},
    -- lsp-trouble plugin
    w = {"<cmd>Trouble workspace_diagnostics<cr>", "Lsp Workspace Diagnostics"},
    d = {"<cmd>Trouble document_diagnostics<cr>", "Lsp Document Diagnostic"},
    j = {"<cmd>Trouble lsp_definitions<cr>", "Lsp Definitions"},
    r = {"<cmd>Trouble lsp_references<cr>", "LSP References"},
    q = {"<cmd>Trouble quickfix<cr>", "Lsp Quickfix"},
  },
  w = {
    name = 'window & word',
    w = {'<cmd>NeoZoomToggle<cr>', 'Toggle window zoom'},
    o = {"<cmd>lua require('nvim-window').pick()<cr>", 'Choose window'},
    t = {"<c-w>t", "Move to new tab"},
    j = {"<c-w>w", "Switch window"},
    -- vim-test plugin
    -- w = {'<cmd>MacDictPopup<cr>', 'search cursor word in macOS distionary'},
    -- d = {'<cmd>MacDictWord<cr>', 'search in macOS distionary and show in quickfix'},
    l = {'<Plug>TranslateW', 'Translate word online'},
  },
}, { prefix = "<leader>" })

wk.register({
  d = {
    name = 'diff view',
    o = {'<cmd>DiffviewOpen<CR>', 'open diffview'},
    u = {'<cmd>DiffviewOpen -uno<CR>', 'open diffview hide untracked files'},
    h = {'<cmd>DiffviewFileHistory<CR>', 'open diffview file history'},
  },
  l = {
    name = 'lsp origin actions',
    d = {'<cmd>lua vim.lsp.buf.definition()<cr>', 'go to definition'},
    D = {'<cmd>lua vim.lsp.buf.declaration()<cr>', 'go to declaration'},
    r = {'<cmd>lua vim.lsp.buf.references()<cr>', 'go to references'},
    a = {'<cmd>lua vim.lsp.buf.code_action()<cr>', 'go to code action'},
    f = {'<cmd>vim.lsp.buf.formatting()<cr>', 'formatting code'},
    R = {'<cmd>LspRestart<cr>', 'restart lsp'},
  },
  o = {
    name = "Go with go.nvim",
    a = { "<cmd>GoAlt<CR>", "alternate impl and test" },
    i = { "<cmd>GoInstall<CR>", "go install" },
    b = { "<cmd>GoBuild<CR>", "go build" },
    d = { "<cmd>GoDoc<CR>", "go doc" },
    f = {"<cmd>GoFmt<cr>", 'formatting code'},
    r = { "<cmd>!go run %:.<CR>", "go run current file" },
    e = { "<cmd>GoIfErr<CR>", "add if err" },
    w = { "<cmd>GoFillSwitch<CR>", "fill switch" },
    g = { "<cmd>GoAddTag<CR>", "add json tag" },
    c = { "<cmd>lua require('go.comment').gen()<CR>", "comment current func" },
    t = {
      name = "Testing",
      t = { "<cmd>GoTestFunc<CR>", "go test -s [current test]" },
      f = { "<cmd>GoTestFile<CR>", "go test [current file]" },
      a = { "<cmd>GoTest ./...<CR>", "go test ./..." },
      c = { "<cmd>GoCoverage<CR>", "annotate with coverage" },
      -- d = { "<cmd>call vimspector#LaunchWithSettings( #{ configuration: 'single test', TestName: go#util#TestName() } )<CR>", "Debug current test" },
    },
  },
}, { prefix = "g" })
-- }}}
