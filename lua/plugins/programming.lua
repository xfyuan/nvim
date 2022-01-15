local g = vim.g
local cmd = vim.cmd

-- vim-test.vim {{{
vim.api.nvim_command("let test#strategy = 'basic'")
-- vim.api.nvim_command("let test#neovim#term_position = 'vert'")
-- vim.api.nvim_command("let test#ruby#rails#executable = 'dip rspec'")
-- vim.api.nvim_command("let test#ruby#rspec#executable = 'dip rspec'")
vim.api.nvim_command("let test#ruby#rspec#executable = 'bundle exec rspec'")
-- }}}

-- any-jump.vim {{{
g.any_jump_search_prefered_engine = 'rg'
g.any_jump_list_numbers = 1
g.any_jump_window_top_offset = 6
g.any_jump_window_width_ratio  = 0.7
g.any_jump_window_height_ratio = 0.7
-- }}}

-- vim-dadbod.vim {{{
g.db_ui_use_nerd_fonts = 1
g.completion_matching_ignore_case = 1

vim.api.nvim_command("let g:completion_matching_strategy_list = ['exact', 'substring']")

vim.api.nvim_command(" let g:completion_chain_complete_list = { 'sql': [ {'complete_items': ['vim-dadbod-completion']}, ], } ")

vim.api.nvim_command("let g:dbs = { 'gd-pg': 'postgres://postgres:postgres@postgres:5432/goldendata_development', 'gd-mongo': 'mongodb://mongo:27017/goldendata_development', 'gd-redis': 'redis:///', 'xy-pg': 'postgres://postgres:postgres@postgres:54320/hotwirex_development' }")

cmd([[xnoremap <expr> <Plug>(DBExe)     db#op_exec()]])
cmd([[nnoremap <expr> <Plug>(DBExe)     db#op_exec()]])
cmd([[xmap <leader>db  <Plug>(DBExe)]])
cmd([[nmap <leader>db  <Plug>(DBExe)]])
cmd([[omap <leader>db  <Plug>(DBExe)]])
cmd([[nmap <leader>dn  <Plug>(DBExeLine)]])
-- }}}

-- formatter.nvim {{{
local prettierConfig = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
    stdin = true
  }
end
require('formatter').setup({
  filetype = {
    lua = {function() return {exe = "lua-format", stdin = true} end},
    json = {prettierConfig},
    html = {prettierConfig},
    javascript = {prettierConfig},
    typescript = {prettierConfig},
    typescriptreact = {prettierConfig}
  }
})
-- }}}

-- Others {{{
require('goto-preview').setup {
  default_mappings = true; -- Bind default mappings
}

require("aerial").setup({
  manage_folds = true,
  link_folds_to_tree = true,
  link_tree_to_folds = true,
})
-- }}}
