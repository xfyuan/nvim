local installer = require('plugins.lsp.installer')

-- Add additional capabilities supported by nvim-cmp
local protocol = vim.lsp.protocol
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  protocol.make_client_capabilities()
)
local completionItem = capabilities.textDocument.completion.completionItem
completionItem.documentationFormat = { 'markdown', 'plaintext' }
completionItem.snippetSupport = true
completionItem.preselectSupport = true
completionItem.insertReplaceSupport = true
completionItem.labelDetailsSupport = true
completionItem.deprecatedSupport = true
completionItem.commitCharactersSupport = true
completionItem.tagSupport = { valueSet = { 1 } }
completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

local attacher = function(client, bufnr)
  require("aerial").on_attach(client, bufnr)

  -- Keymaps
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = {noremap = true, silent = true}

  buf_set_keymap("n", "glD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gld", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "glr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gla", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "glf", "<cmd>vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "glR", "<cmd>LspRestart<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

  print('LSP: ' .. client.name)
end

-- Configure LSPs installed by installer
installer.setup(attacher, capabilities)
