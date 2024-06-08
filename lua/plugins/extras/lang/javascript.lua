return {
  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx", "vue" })
    end,
  },
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "pmizio/typescript-tools.nvim" },
    opts = {
      servers = {
        -- tsserver = {
        --   filetypes = {
        --     'typescript',
        --     'vue',
        --   },
        --   init_options = {
        --     plugins = {
        --       {
        --         name = '@vue/typescript-plugin',
        --         location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
        --         languages = { 'javascript', 'typescript', 'vue' },
        --       },
        --     },
        --   },
        -- },

        -- volar = { filetypes = { 'vue' } },
        volar = {
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        --   init_options = {
        --     typescript = {
              -- tsdk = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/typescript/lib",
        --     },
        -- },
        },
      },
    },
  },
}
