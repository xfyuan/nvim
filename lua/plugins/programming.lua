local g = vim.g
local cmd = vim.cmd

-- vim-test.vim {{{
vim.api.nvim_command("let test#strategy = 'basic'")
-- vim.api.nvim_command("let test#neovim#term_position = 'vert'")
-- vim.api.nvim_command("let test#ruby#rails#executable = 'dip rspec'")
-- vim.api.nvim_command("let test#ruby#rspec#executable = 'dip rspec'")
vim.api.nvim_command("let test#ruby#rspec#executable = 'bundle exec rspec'")
vim.api.nvim_command("let test#go#gotest#executable = 'go test -v'")
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

-- Copilot.nvim {{{
cmd([[imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")]])
g.copilot_no_tab_map = true
-- }}}

-- nvim-lightbulb {{{
cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
-- }}}

-- Others {{{
require("aerial").setup({
  manage_folds = true,
  link_folds_to_tree = true,
  link_tree_to_folds = true,
})
-- }}}

-- DAP {{{
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
-- }}}
