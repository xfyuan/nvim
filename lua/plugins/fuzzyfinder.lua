-- telescope {{{
local telescope = require('telescope')
local actions = require('telescope.actions')
-- local builtin = require('telescope.builtin')

-- local utils = vim.my.utils

telescope.setup({
  extensions = {
    fzf = {
      case_mode = 'smart_case',
      fuzzy = true,
      override_file_sorter = true,
      override_generic_sorter = true,
    },
  },

  defaults = {
    dynamic_preview_title = true,
    layout_config = {
      prompt_position = 'top',
      flex = {
        flip_columns = 250,
        flip_lines = 50,
        vertical = {
          height = 0.99,
          width = 0.7,
          mirror = true,
        },
        horizontal = {
          height = 0.99,
          width = 0.99,
          mirror = false,
        },
      },
    },
    layout_strategy = 'flex',
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["jj"] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-u>'] = { '<c-u>', type = 'command' }, -- delete inputted text
      },
      n = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-u>'] = { '<c-u>', type = 'command' }, -- delete inputted text
      },
    },
    path_display = { 'smart' },
    preview_title = '',
    prompt_prefix = '› ',
    selection_caret = '› ',
    set_env = { ['COLORTERM'] = 'truecolor' },
    sorting_strategy = 'ascending',
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    winblend = 0,
  },
})

telescope.load_extension('fzf')
telescope.load_extension('heading')
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
