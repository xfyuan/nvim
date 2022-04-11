local g = vim.g

g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 3
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  folder_arrows = 0,
  files = 1,
}
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
  update_focused_file = { enable = true },
  view = {
    width = 32,
    side = 'left',
    auto_resize = false,
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
