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

g.nvim_tree_side = "left"
g.nvim_tree_width = 36
g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 1
g.nvim_tree_quit_on_open = 0
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
-- g.nvim_tree_git_hl = 0
g.nvim_tree_root_folder_modifier = ":t"
g.nvim_tree_tab_open = 0
g.nvim_tree_allow_resize = 1

g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
}

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌"
    },
    folder = {
        default = "",
        open = "",
        symlink = "",
        empty = "",
        empty_open = "",
        symlink_open = ""
    }
}
-- Mappings for nvimtree

vim.api.nvim_set_keymap(
    "n",
    "<C-u>",
    ":NvimTreeToggle<CR>",
    {
        noremap = true,
        silent = true
    }
)

local tree_cb = require "nvim-tree.config".nvim_tree_callback
vim.g.nvim_tree_bindings = {
      { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-}>"},    cb = tree_cb("cd") },
      { key = "<C-v>",                        cb = tree_cb("vsplit") },
      { key = "<C-x>",                        cb = tree_cb("split") },
      { key = "<C-t>",                        cb = tree_cb("tabnew") },
      { key = "<",                            cb = tree_cb("prev_sibling") },
      { key = ">",                            cb = tree_cb("next_sibling") },
      { key = "P",                            cb = tree_cb("parent_node") },
      { key = "<BS>",                         cb = tree_cb("close_node") },
      { key = "<S-CR>",                       cb = tree_cb("close_node") },
      { key = "<Tab>",                        cb = tree_cb("preview") },
      { key = "K",                            cb = tree_cb("first_sibling") },
      { key = "J",                            cb = tree_cb("last_sibling") },
      { key = "I",                            cb = tree_cb("toggle_ignored") },
      { key = "H",                            cb = tree_cb("toggle_dotfiles") },
      { key = "R",                            cb = tree_cb("refresh") },
      { key = "a",                            cb = tree_cb("create") },
      { key = "d",                            cb = tree_cb("remove") },
      { key = "r",                            cb = tree_cb("rename") },
      { key = "<C->",                         cb = tree_cb("full_rename") },
      { key = "x",                            cb = tree_cb("cut") },
      { key = "c",                            cb = tree_cb("copy") },
      { key = "p",                            cb = tree_cb("paste") },
      { key = "y",                            cb = tree_cb("copy_name") },
      { key = "Y",                            cb = tree_cb("copy_path") },
      { key = "gy",                           cb = tree_cb("copy_absolute_path") },
      { key = "[c",                           cb = tree_cb("prev_git_item") },
      { key = "}c",                           cb = tree_cb("next_git_item") },
      { key = "-",                            cb = tree_cb("dir_up") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
    }
-- g.nvim_tree_bindings = {
--     ["u"] = ":lua require'some_module'.some_function()<cr>",
--     -- default mappings
--     ["<CR>"] = tree_cb("edit"),
--     ["o"] = tree_cb("edit"),
--     -- ["<2-LeftMouse>"] = tree_cb("edit"),
--     -- ["<2-RightMouse>"] = tree_cb("cd"),
--     ["<C-]>"] = tree_cb("cd"),
--     ["<C-n>"] = tree_cb("vsplit"),
--     ["<C-h>"] = tree_cb("split"),
--     ["<C-t>"] = tree_cb("tabnew"),
--     ["<"] = tree_cb("prev_sibling"),
--     [">"] = tree_cb("next_sibling"),
--     ["<BS>"] = tree_cb("close_node"),
--     ["<S-CR>"] = tree_cb("close_node"),
--     ["<Tab>"] = tree_cb("preview"),
--     ["I"] = tree_cb("toggle_ignored"),
--     ["H"] = tree_cb("toggle_dotfiles"),
--     ["R"] = tree_cb("refresh"),
--     ["a"] = tree_cb("create"),
--     ["d"] = tree_cb("remove"),
--     ["r"] = tree_cb("rename"),
--     ["<C-r>"] = tree_cb("full_rename"),
--     ["x"] = tree_cb("cut"),
--     ["c"] = tree_cb("copy"),
--     ["p"] = tree_cb("paste"),
--     ["y"] = tree_cb("copy_name"),
--     ["Y"] = tree_cb("copy_path"),
--     ["gy"] = tree_cb("copy_absolute_path"),
--     ["[c"] = tree_cb("prev_git_item"),
--     ["]c"] = tree_cb("next_git_item"),
--     ["-"] = tree_cb("dir_up"),
--     ["q"] = tree_cb("close")
-- }
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
