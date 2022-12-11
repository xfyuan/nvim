local M = {}
local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

function M.setup()
  nls.setup({
    sources = {
      -- formatting
      nls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
      nls.builtins.formatting.prettier.with({
        extra_args = { "--single-quote", "false" },
      }),
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.gofumpt,
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.jq,

      -- diagnostics
      nls.builtins.diagnostics.eslint_d,
      nls.builtins.diagnostics.standardrb,
      nls.builtins.diagnostics.golangci_lint,
      nls.builtins.diagnostics.zsh,

      -- code actions
      nls.builtins.code_actions.eslint_d,
      nls.builtins.code_actions.gitrebase,
      nls.builtins.code_actions.gitsigns,
      nls.builtins.code_actions.shellcheck,
    },

    on_attach = function(client, bufnr)
      local wk = require("which-key")
      local default_options = { silent = true }
      wk.register({
        m = {
          F = { "<cmd>lua require('plugins.lsp').toggle_autoformat()<cr>", "Toggle format on save" },
        },
      }, { prefix = "<leader>", mode = "n", default_options })
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            if AUTOFORMAT_ACTIVE then -- global var defined in lsp/init.lua
              vim.lsp.buf.format({ bufnr = bufnr })
            end
          end,
        })
      end
    end,
  })
end

return M
