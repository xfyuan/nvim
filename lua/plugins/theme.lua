return {
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    config = function()
      require("styler").setup({
        themes = {
          markdown = { colorscheme = "catppuccin-mocha" },
          help = { colorscheme = "gruvbox" },
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },
  { "ellisonleao/gruvbox.nvim", lazy = false, config = true },
  { "catppuccin/nvim", lazy = false, name = "catppuccin" },
}
