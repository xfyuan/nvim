local cmd = vim.cmd
-- local g = vim.g

-- local opt = {}
local opt = { silent = true }

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
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

-- cmd("inoremap jj <Esc>")
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
map("n", "H", "getpos('.')[2] == 1 ? 'k' : '^'", { expr = true })
-- Go to end of line. Goes to next line if repeated
map("n", "L", "len(getline('.')) == 0 || len(getline('.')) == getpos('.')[2] ? 'jg_' : 'g_'", { expr = true })

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
map("n", "<leader>dft", "&diff ? ':windo diffoff<cr>' : ':windo diffthis<cr>'", { expr = true })
-- }}}

-- ================= Plugins Mapping ================= -- {{{
-- map("n", "<C-p>", [[<Cmd>GitFiles<CR>]], opt)
map("n", "<C-p>", [[<Cmd>Telescope git_files<CR>]], opt)

-- map("n", "<C-e>", [[<Cmd>CtrlSF<CR>]], opt)

map("n", "<leader>sR", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", opt)
map("v", "<leader>sR", "<cmd>lua require('spectre').open_visual()<cr>", opt)
map("n", "<leader>sF", "viw:lua require('spectre').open_file_search()<cr>", opt)
map("n", "<leader>sO", ":lua require('spectre').open()<cr>", opt)

cmd([[nmap <C-]> <Plug>(fzf_tags)]])

map("v", "<leader>aa", ":SimpleAlign ", {})
-- }}}

-- ================= Whichkey Mapping ================= -- {{{
local wk = require("which-key")

wk.setup({
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "i", "j", "k", "h", "u", "v" },
    v = { "j", "k" },
  },
})

local n_opts = { mode = "n", prefix = "<leader>" }
local v_opts = { mode = "v", prefix = "<leader>" }
local g_opts = { mode = "n", prefix = "g" }

local normal_keymap = {
  -- ['<leader>'] = {'<cmd>GitFiles<cr>', 'find git files'},
  -- ['1'] = {':normal "lyy"lpwv$r=^"lyyk"lP<cr>', 'mark ======'},
  q = { ":q!<cr>", "Quit without saving" },
  Q = { ":qa!<cr>", "Quit all windows without saving" },
  k = { "<Plug>DashSearch", "Search word in Dash" }, -- dash.vim plugin
  o = { "<cmd>AerialToggle<cr>", "Toggle code outline window" }, -- aerial.nvim plugin
  d = {
    name = "Debugger/Diff/DB/Buffer",
    f = {
      name = "Diff view",
      o = { "<cmd>DiffviewOpen<CR>", "Open diffview" },
      u = { "<cmd>DiffviewOpen -uno<CR>", "Open diffview hide untracked files" },
      h = { "<cmd>DiffviewFileHistory<CR>", "Open diffview file history" },
    },
    -- bufdelete.nvim plugin
    d = { "<cmd>Bdelete<cr>", "Delete buffer" },
    -- vim-dadbod plugin
    -- u = {'<cmd>DBUI<cr>', 'open db ui'},
    -- l = {'<Plug>(DBExeLine)', 'run line as query'},
    -- g = { function() require('dapui').toggle() end, "Toggle debbuger" },
    b = { function() require("dap").toggle_breakpoint() end, "Toggle breakpoint", },
    c = { function() require("dap").continue() end, "Continue or start debuggger", },
    n = { function() require("dap").step_over() end, "Step over", },
    i = { function() require("dap").step_into() end, "Step in", },
    o = { function() require("dap").step_out() end, "Step out", },
    k = { function() require("dap").up() end, "Go up", },
    j = { function() require("dap").down() end, "Go down", },
    u = { function() require("dapui").toggle() end, "Toggle UI", },
    t = {
      function()
        local dap = require("dap")
        dap.run({
          type = "go",
          name = "",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
          args = { "-test.run", "" },
        })
      end,
      "Debug test",
    },
  },
  f = {
    name = "Fuzzy finder",
    -- fzf.vim
    -- j = {'<cmd>GitFiles<cr>', 'find git files'},
    -- f = {'<cmd>Files<cr>', 'find files'},
    -- b = {'<cmd>Buffers<cr>', 'find buffers'},
    -- o = {'<cmd>History<cr>', 'find old history'},
    -- telescope
    o = { "<cmd>Telescope git_files<cr>", "Find git files" },
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    b = { "<cmd>Telescope buffers<cr>", "Find buffers" },
    h = { "<cmd>Telescope oldfiles<cr>", "Opened files history" },
    s = { "<cmd>Telescope luasnip<cr>", "Search snippet" },
    p = { "<cmd>Telescope packer<cr>", "List packer info" },
    P = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "Find project" },
  },
  g = {
    name = "Git",
    -- telescope
    l = { "<cmd>Telescope git_status<cr>", "Changed files" },
    -- vim-fugitive plugin
    g = { "<cmd>Git blame<cr>", "Blame" },
    s = { "<cmd>Git<cr>", "Status" },
    -- l = {'<cmd>GFiles?<cr>', 'changed files'},
    d = { "<cmd>Gdiff<cr>", "Diff" },
    r = { "<cmd>Gread<cr>", "Read" },
    -- w = {'<cmd>Gwrite<cr>', 'write'},
    p = { "<cmd>Git push<cr>", "Push" },
    c = { "<cmd>Gcommit -v<cr>", "Commit" },
    -- gitsigns plugin
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    a = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    -- vim-rhubarb plugin
    -- b = {'<cmd>Gbrowser<cr>', 'browse github'},
    -- gv.vim plugin
    h = { "<cmd>GV!<cr>", "List only current file commits" },
  },
  j = {
    name = "Hop(easymotion)",
    -- hop.nvim plugin
    j = { "<cmd>HopWord<cr>", "Word" },
    c = { "<cmd>HopChar2<cr>", "2 char" },
    l = { "<cmd>HopLine<cr>", "Line" },
    p = { "<cmd>HopPattern<cr>", "Pattern" },
    -- vim-prettier plugin
    -- t = {'<Plug>(Prettier)', 'prettier format current buffer'},
  },
  r = {
    name = "Refactor",
    i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
    b = { [[<cmd>lua require('refactoring').refactor('Exract Block')<cr>]], "Extract Block" },
    B = { [[<cmd>lua require('refactoring').refactor('Exract Block To File')<cr>]], "Extract Block to File" },
    P = {
      [[<cmd>lua require('refactoring').debug.printf({below = false})<cr>]],
      "Debug Print",
    },
    p = {
      [[<cmd>lua require('refactoring').debug.print_var({normal = true})<cr>]],
      "Debug Print Variable",
    },
    c = { [[<cmd>lua require('refactoring').debug.cleanup({})<cr>]], "Debug Cleanup" },
  },
  s = {
    name = "Search/Session/Spectre",
    -- search
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    H = { "<cmd>Telescope heading<cr>", "Find Header" },
    m = { "<cmd>Telescope marks<cr>", "Find Mark" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    s = { "<cmd>Telescope grep_string<cr>", "Text under cursor" },
    S = { "<cmd>Telescope symbols<cr>", "Search symbols" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    -- session
    a = { "<cmd>SaveSession<cr>", "Add auto session" },
    l = { "<cmd>RestoreSession<cr>", "Load auto session" },
    d = { "<cmd>DeleteSession<cr>", "Delete auto session" },
    f = { "<cmd>SearchSession<cr>", "Search auto session" },
  },
  t = {
    name = "Test",
    -- vim-test plugin
    t = { "<cmd>TestNearest<cr>", "Test nearest case" },
    l = { "<cmd>TestLast<cr>", "Test last case" },
    f = { "<cmd>TestFile<cr>", "Test whole file" },
    o = { "<cmd>TodoLocList<cr>", "List todos in quickfix" },
  },
  u = {
    name = "Url view",
    u = { "<cmd>UrlView buffer<cr>", "Find URL and open" },
    l = { "<cmd>UrlView buffer action=clipboard<cr>", "Copy URL" },
  },
  w = {
    name = "Window/Word",
    w = { "<cmd>FocusMaxOrEqual<cr>", "Toggle window zoom" },
    s = { "<cmd>FocusSplitNicely<cr>", "Split a window on golden ratio" },
    o = { "<cmd>lua require('nvim-window').pick()<cr>", "Choose window" },
    t = { "<c-w>t", "Move to new tab" },
    m = { "<cmd>MarkdownPreview<cr>", "Open markdown preview window" },
    -- w = {'<cmd>MacDictPopup<cr>', 'search cursor word in macOS distionary'},
    -- d = {'<cmd>MacDictWord<cr>', 'search in macOS distionary and show in quickfix'},
    l = { "<Plug>TranslateW", "Translate word online" },
  },
}

local visual_keymap = {
  g = {
    name = "Git",
    Y = {
      "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
      "Open permalinks of selected area",
    },
  },
  r = {
    name = "Refactor",
    f = { [[<cmd>lua require('refactoring').refactor('Extract Function')<cr>]], "Extract Function" },
    F = {
      [[ <cmd>lua require('refactoring').refactor('Extract Function to File')<cr>]],
      "Extract Function to File",
    },
    v = { [[<cmd>lua require('refactoring').refactor('Extract Variable')<cr>]], "Extract Variable" },
    i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
    r = { [[<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>]], "Refactor finder" },
    d = { [[<cmd>lua require('refactoring').debug.print_var({})<cr>]], "Debug Print Var" },
  },
}

local global_keymap = {
  c = {
    name = "Comment box",
    B = { "<cmd>CBcbox10<CR>", "Comment box ascii" },
  },
  o = {
    name = "Go with go.nvim",
    a = { "<cmd>GoAlt<CR>", "Alternate impl and test" },
    i = { "<cmd>GoInstall<CR>", "Go install" },
    b = { "<cmd>GoBuild<CR>", "Go build" },
    d = { "<cmd>GoDoc<CR>", "Go doc" },
    f = { "<cmd>GoFmt<cr>", "Formatting code" },
    r = { "<cmd>!go run %:.<CR>", "Go run current file" },
    e = { "<cmd>GoIfErr<CR>", "Add if err" },
    w = { "<cmd>GoFillSwitch<CR>", "Fill switch" },
    g = { "<cmd>GoAddTag<CR>", "Add json tag" },
    c = { "<cmd>lua require('go.comment').gen()<CR>", "Comment current func" },
    t = {
      name = "Testing",
      t = { "<cmd>GoTestFunc<CR>", "Go test -s [current test]" },
      f = { "<cmd>GoTestFile<CR>", "Go test [current file]" },
      a = { "<cmd>GoTest ./...<CR>", "Go test ./..." },
      c = { "<cmd>GoCoverage<CR>", "Annotate with coverage" },
      -- d = { "<cmd>call vimspector#LaunchWithSettings( #{ configuration: 'single test', TestName: go#util#TestName() } )<CR>", "Debug current test" },
    },
  },
}

wk.register(normal_keymap, n_opts)
wk.register(visual_keymap, v_opts)
wk.register(global_keymap, g_opts)
-- }}}
