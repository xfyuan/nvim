local g = vim.g

-- automatically close the tab/vim when nvim-tree is the last window in the tab
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  filters = {
    dotfiles = true,
  },
  git = {
    enable = true,
    ignore = true,
  },
  ignore_ft_on_setup = {
    '.git',
    'node_modules',
    '.byebug_history',
    '.vscode',
    '.idea',
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = '3',
  },
  update_focused_file = { enable = true },
  view = {
    width = 32,
    side = 'left',
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
  },
})

vim.api.nvim_set_keymap(
    "n",
    "<C-u>",
    ":NvimTreeToggle<CR>",
    {
        noremap = true,
        silent = true
    }
)
