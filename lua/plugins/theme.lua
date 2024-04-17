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
      require('tokyonight').setup {
        dim_inactive = true,
        on_colors = function(c)
          c.bg_dark = "#1e2030"
          c.border = c.dark3
        end,
        -- on_colors = function(c)
        --   c.border = c.dark3
        -- end,
      }
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },
  { "ellisonleao/gruvbox.nvim", lazy = false, config = true },
  { "catppuccin/nvim", lazy = false, name = "catppuccin" },
}
