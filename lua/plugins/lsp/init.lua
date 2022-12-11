local M = {}
local util = require("lspconfig.util")

--  +----------------------------------------------------------+
--  |               LSP ensure installed server                |
--  +----------------------------------------------------------+
local servers = {
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins", "MiniTest" },
          -- disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
          -- library = vim.api.nvim_get_runtime_file("", true),
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
        completion = { callSnippet = "Replace" },
        telemetry = { enable = false },
        hint = {
          enable = false,
        },
      },
    },
  },
  tsserver = {
    disable_formatting = true,
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  },
  yamlls = {
    schemastore = {
      enable = true,
    },
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
      },
    },
  },
  solargraph = {
    root_dir = util.root_pattern(".git", "Gemfile"),
    settings = {
      solargraph = {
        completion = true,
        symbols = true,
        diagnostics = true,
        definitions = true,
        hover = true,
        references = true,
        rename = true,
        useBundler = true,
      },
    },
  },
  bashls = {},
  cssls = {},
  dockerls = {},
  html = {},
  marksman = {},
  jsonls = {},
  tailwindcss = {},
  vimls = {},
}

--  +----------------------------------------------------------+
--  |                        LSP setup                         |
--  +----------------------------------------------------------+
function M.on_attach(client, bufnr)
  local caps = client.server_capabilities

  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  if caps.completionProvider then
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  end

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  if caps.documentFormattingProvider then
    vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  end

  -- Configure key mappings
  require("plugins.lsp.keymaps").setup(client, bufnr)

  -- Configure highlighting
  require("plugins.lsp.highlighter").setup(client, bufnr)

  -- Configure formatting
  -- require("pluginslsp.null-ls.formatters").setup(client, bufnr)

  -- tagfunc
  if caps.definitionProvider then
    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  -- nvim-navic
  if caps.documentSymbolProvider then
    local navic = require "nvim-navic"
    navic.attach(client, bufnr)
  end

  if client.name ~= "null-ls" then
    -- inlay-hints
    local ih = require("inlay-hints")
    ih.on_attach(client, bufnr)

    -- -- semantic highlighting
    -- if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    --   local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
    --   vim.api.nvim_create_autocmd("TextChanged", {
    --     group = augroup,
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.buf.semantic_tokens_full()
    --     end,
    --   })
    --   -- fire it first time on load as well
    --   vim.lsp.buf.semantic_tokens_full()
    -- end
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits", },
}
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp

local opts = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Setup LSP handlers
require("plugins.lsp.handlers").setup()

function M.setup()
  -- null-ls
  require("plugins.lsp.null-ls").setup()

  -- Installer
  require("plugins.lsp.mason").setup(servers, opts)

  -- Signature
  require("lsp_signature").setup()
end

--  +----------------------------------------------------------+
--  |                        Some Utils                        |
--  +----------------------------------------------------------+
local diagnostics_active = true
-- toggle diagnostics
function M.toggle_diagnostics()
  vim.notify("Toggling diagnostics show", vim.log.levels.INFO, { title = "Diagnostics" })
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

AUTOFORMAT_ACTIVE = false -- must be global since the toggle function is called in which.lua
-- toggle null-ls's autoformatting
function M.toggle_autoformat()
  vim.notify("Toggling autoformatting", vim.log.levels.INFO, { title = "Formatter" })
  AUTOFORMAT_ACTIVE = not AUTOFORMAT_ACTIVE
end

return M
