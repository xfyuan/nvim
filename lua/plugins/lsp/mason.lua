local M = {}

function M.setup(servers, server_options)
  local lspconfig = require("lspconfig")

  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      border = "rounded",
    },
  })

  require("mason-tool-installer").setup({
    ensure_installed = {
      -- Formatter
      "stylua",
      "prettier",
      "shfmt",
      "jq",
      -- Linter
      "eslint_d",
      "standardrb",
      "golangci-lint",
      "shellcheck",
      "yamllint",
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
  })

  require("mason-lspconfig").setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
  })

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      local opts = vim.tbl_deep_extend("force", server_options, servers[server_name] or {})
      lspconfig[server_name].setup(opts)
    end,
    ["sumneko_lua"] = function()
      local opts = vim.tbl_deep_extend("force", server_options, servers["sumneko_lua"] or {})
      require("neodev").setup({})
      lspconfig.sumneko_lua.setup(opts)
    end,
    ["tsserver"] = function()
      local opts = vim.tbl_deep_extend("force", server_options, servers["tsserver"] or {})
      require("typescript").setup({
        disable_commands = false,
        debug = false,
        server = opts,
      })
    end,
  })
end

return M
