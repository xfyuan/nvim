return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ruby", })
    end,
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, { "solargraph", })
  --   end,
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       solargraph = {
  --         -- root_dir = require("lspconfig.util").root_pattern(".git", "Gemfile"),
  --         settings = {
  --           solargraph = {
  --             completion = true,
  --             symbols = true,
  --             diagnostics = true,
  --             definitions = true,
  --             hover = true,
  --             references = true,
  --             rename = true,
  --             useBundler = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
