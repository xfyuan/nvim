if vim.g.neovide then
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_hide_mouse_when_typing = true
  vim.opt.mouse = "a"
  vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h20"

  vim.g.neovide_transparency = 0.95
  vim.g.transparency = 0.8

  vim.cmd('vnoremap <D-c> "*y')
  vim.cmd('nnoremap <D-v> "*p')
  vim.cmd('inoremap <D-v> <C-r>+')
end
