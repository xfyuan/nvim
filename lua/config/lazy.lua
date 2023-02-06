--- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.extras.lang" },
    { import = "plugins.extras.tool" },
    { import = "plugins.extras.ui" },
  },
  concurrency = 24,
  defaults = { lazy = true, version = nil },
  install = { missing = true, colorscheme = { "tokyonight" } },
  ui = { border = "rounded" },
})
vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })
