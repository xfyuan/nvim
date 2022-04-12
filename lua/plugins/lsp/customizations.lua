local util = require('lspconfig.util')
local fn = vim.fn

return {
  sumneko_lua = {
    root_dir = util.root_pattern('.stylua.toml'),
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            'vim',
            'hs', -- hammerspoon
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [fn.expand('$VIMRUNTIME/lua')] = true,
            [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    },
  },

  gopls = {
    root_dir = util.root_pattern('.git', 'go.mod'),
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  },

  -- sqlls = {
  --   cmd = { '$HOME/.asdf/shims/sql-language-server', 'up', '--method', 'stdio' },
  -- },

  solargraph = {
    root_dir = util.root_pattern('.git', 'Gemfile'),
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

  tsserver = {
    init_options = require("nvim-lsp-ts-utils").init_options,
    on_attach = function(client)
      local ts_utils = require('nvim-lsp-ts-utils')
      ts_utils.setup({
        update_imports_on_move = true,
        degbug = false,
      })
      ts_utils.setup_client(client)
    end
  }
}
