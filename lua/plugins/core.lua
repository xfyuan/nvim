-- telescope {{{
local actions = require('telescope.actions')
require("telescope").setup {
    defaults = {
        -- prompt_position = "top",
        sorting_strategy = "ascending",
        prompt_prefix = " ",
        selection_caret = " ",
        layout_config = {
            horizontal = {
                prompt_position = 'top',
                mirror = false,
                preview_width = 0.5
            },
            vertical = {
                mirror = false
            }
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["jj"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },
}

local opt = {noremap = true, silent = true}

-- mappings
-- vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fm", [[<Cmd> Neoformat<CR>]], opt)

-- dashboard stuff
-- vim.api.nvim_set_keymap("n", "<Leader>fw", [[<Cmd> Telescope live_grep<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fn", [[<Cmd> DashboardNewFile<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>bm", [[<Cmd> DashboardJumpMarks<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>sl", [[<Cmd> SessionLoad<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>ss", [[<Cmd> SessionSave<CR>]], opt)
-- }}}

-- fzf.vim {{{
vim.api.nvim_command("let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }")
vim.api.nvim_exec(
[[
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, { 'options': '--color hl:123,hl+:222' }, a:fullscreen)
endfunction
]],
true)

vim.cmd("command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)")
-- }}}

-- nvim-tree {{{
local g = vim.g
vim.o.termguicolors = true

g.nvim_tree_git_hl = 1
g.nvim_tree_group_empty = 1
-- g.nvim_tree_indent_markers = 1
g.nvim_tree_highlight_opened_files = 2
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  folder_arrows = 1,
  files = 1,
}
-- g.nvim_tree_root_folder_modifier = ":t"

require'nvim-tree'.setup {
  view = {
    width = 36,
    side = 'left',
  },
  auto_close = true,
  hijack_cursor = true,
  update_focused_file = { enable = true },
  ignore_ft_on_setup  = {
    '.git',
    'node_modules',
    '.byebug_history',
    '.vscode',
    '.idea',
  },
  filters = {
    dotfiles = true,
    custom = {}
  }
}

vim.api.nvim_set_keymap(
    "n",
    "<C-u>",
    ":NvimTreeToggle<CR>",
    {
        noremap = true,
        silent = true
    }
)
-- }}}

-- git signs {{{
require("gitsigns").setup {
    signs = {
        add = {hl = "DiffAdd", text = "▌", numhl = "GitSignsAddNr"},
        change = {hl = "DiffChange", text = "▌", numhl = "GitSignsChangeNr"},
        delete = {hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr"},
        topdelete = {hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr"},
        changedelete = {hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr"}
    },
    numhl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,
        ["n ]c"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''},
        ["n [c"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''},
        ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>'
    },
    watch_index = {
        interval = 100
    },
    sign_priority = 5,
    status_formatter = nil -- Use default
}
-- }}}

require('hop').setup{}
require("nvim-autopairs").setup()
require("toggleterm").setup{
    direction = 'float',
    open_mapping = [[<c-\>]],
}

require'nvim-lastplace'.setup {
  lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
  lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
  lastplace_open_folds = true
}

-- hide line numbers , statusline in specific buffers!
vim.api.nvim_exec(
    [[
   au BufEnter term://* setlocal nonumber
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
   au BufEnter term://* set laststatus=0
]],
    false
)
