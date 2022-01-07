local g = vim.g
local cmd = vim.cmd

-- lsp config {{{
local servers = {
    "gopls",
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    -- "sumneko_lua",
    "solargraph",
}

function on_attach(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    require "lsp_signature".on_attach()
    require("aerial").on_attach(client, bufnr)

    -- Mappings.
    -- local opts = {noremap = true, silent = true}
    --
    -- buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    -- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    -- buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    -- buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    -- buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    -- if client.resolved_capabilities.document_formatting then
    --     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- elseif client.resolved_capabilities.document_range_formatting then
    --     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    -- end
end

-- lspInstall + lspconfig stuff

local lsp_installer = require("nvim-lsp-installer")

for _, name in pairs(servers) do
  local ok, server = lsp_installer.get_server(name)
  -- Check that the server is supported in nvim-lsp-installer
  if ok then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

local nvim_lsp = require('lspconfig')
for _, lsp in ipairs(servers) do
  lsp_installer.on_server_ready(function(lsp)
    local opts = {}
    lsp:setup(opts)
  end)

  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    -- root_dir = vim.loop.cwd,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- replace the default lsp diagnostic letters with prettier symbols
-- vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
-- vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
-- vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
-- vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})
-- }}}

-- lsp treesitters {{{
local ts_config = require("nvim-treesitter.configs")

ts_config.setup {
    ensure_installed = {
        "javascript",
        "html",
        "css",
        "bash",
        "lua",
        "json",
        "python",
        "ruby",
        "go"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
-- }}}

-- nvim-cmp {{{
local cmp = require('cmp')

cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'spell' },
  },
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-j>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  },
  formatting = {
    format = function(entry, vim_item)
      local icon = require('lspkind').presets.default[vim_item.kind]
      vim_item.kind = string.format('%s %s', icon, vim_item.kind)

      vim_item.menu = ({
        buffer = '[Buffer]',
        vsnip = '[VSnip]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        spell = '[Spell]'
      })[entry.source.name]

      return vim_item
    end,
  },
}
-- }}}

-- vim-test.vim {{{
vim.api.nvim_command("let test#strategy = 'basic'")
-- vim.api.nvim_command("let test#neovim#term_position = 'vert'")
-- vim.api.nvim_command("let test#ruby#rails#executable = 'dip rspec'")
-- vim.api.nvim_command("let test#ruby#rspec#executable = 'dip rspec'")
vim.api.nvim_command("let test#ruby#rspec#executable = 'bundle exec rspec'")
-- }}}

-- any-jump.vim {{{
g.any_jump_search_prefered_engine = 'rg'
g.any_jump_list_numbers = 1
g.any_jump_window_top_offset = 6
g.any_jump_window_width_ratio  = 0.7
g.any_jump_window_height_ratio = 0.7
-- }}}

-- vim-dadbod.vim {{{
g.db_ui_use_nerd_fonts = 1
g.completion_matching_ignore_case = 1

vim.api.nvim_command("let g:completion_matching_strategy_list = ['exact', 'substring']")

vim.api.nvim_command(" let g:completion_chain_complete_list = { 'sql': [ {'complete_items': ['vim-dadbod-completion']}, ], } ")

vim.api.nvim_command("let g:dbs = { 'gd-pg': 'postgres://postgres:postgres@postgres:5432/goldendata_development', 'gd-mongo': 'mongodb://mongo:27017/goldendata_development', 'gd-redis': 'redis:///', 'xy-pg': 'postgres://postgres:postgres@postgres:54320/hotwirex_development' }")

cmd([[xnoremap <expr> <Plug>(DBExe)     db#op_exec()]])
cmd([[nnoremap <expr> <Plug>(DBExe)     db#op_exec()]])
cmd([[xmap <leader>db  <Plug>(DBExe)]])
cmd([[nmap <leader>db  <Plug>(DBExe)]])
cmd([[omap <leader>db  <Plug>(DBExe)]])
cmd([[nmap <leader>dn  <Plug>(DBExeLine)]])
-- }}}

require("lspkind").init()

-- require("nvim_comment").setup()

require('goto-preview').setup {
  default_mappings = true; -- Bind default mappings
}

require("aerial").setup({
  manage_folds = true,
  link_folds_to_tree = true,
  link_tree_to_folds = true,
})

-- formatter.nvim {{{
local prettierConfig = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
    stdin = true
  }
end
require('formatter').setup({
  filetype = {
    lua = {function() return {exe = "lua-format", stdin = true} end},
    json = {prettierConfig},
    html = {prettierConfig},
    javascript = {prettierConfig},
    typescript = {prettierConfig},
    typescriptreact = {prettierConfig}
  }
})
-- }}}
