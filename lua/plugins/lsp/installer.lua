local lspconfig = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')
local customizations = require('plugins.lsp.customizations')

local M = {}

M.servers = {
  'bashls',
  'cssls',
  'gopls',
  'html',
  'jsonls',
  'solargraph',
  'sumneko_lua',
  'tailwindcss',
  'tsserver',
  'vuels',
  'yamlls',
  -- 'sqlls',
  -- 'sqls',
  -- 'vimls',
}

local check_installed = function()
  local installed = vim.tbl_map(function(config)
    return config.name
  end, lsp_installer.get_installed_servers())

  for _, server in ipairs(installed) do
    if not vim.tbl_contains(M.servers, server) then
      vim.notify('LSP servers list missing: ' .. server, vim.log.levels.ERROR)
      break
    end
  end
end

M.setup = function(attacher, capabilities)
  local handlers =  {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'rounded'}),
  }
  local default_opts = {
    single_file_support = true,
    capabilities = capabilities,
    handlers = handlers,
    on_attach = attacher,
  }

  check_installed()

  lsp_installer.settings({
    ui = {
      icons = {
        server_installed = '',
        server_pending = '',
        server_uninstalled = '',
      },
    },
  })

  lsp_installer.on_server_ready(function(server)
    local config = vim.tbl_extend('keep', customizations[server.name] or {}, default_opts)
    server:setup(vim.tbl_extend('keep', config, lspconfig[server.name]))
    vim.cmd 'do User LspAttachBuffers'
  end)

  require("lsp_signature").setup()
end

M.install = function()
  for _, server in ipairs(M.servers) do
    lsp_installer.install(server)
  end
end

return M
