if vim.g.neovide then
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_hide_mouse_when_typing = true
  vim.opt.mouse = "a"

  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.95
  vim.g.transparency = 0.8
end
