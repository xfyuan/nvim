local g = vim.g
local cmd = vim.cmd

-- lsp config {{{
function on_attach(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

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

local function setup_servers()
    require "lspinstall".setup()

    local lspconf = require("lspconfig")
    local servers = require "lspinstall".installed_servers()

    for _, lang in pairs(servers) do
        if lang ~= "lua" then
            lspconf[lang].setup {
                on_attach = on_attach,
                root_dir = vim.loop.cwd
            }
        elseif lang == "lua" then
            lspconf[lang].setup {
                root_dir = function()
                    return vim.loop.cwd()
                end,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"}
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                            }
                        },
                        telemetry = {
                            enable = false
                        }
                    }
                }
            }
        end
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require "lspinstall".post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})
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

-- nvim-compe {{{
require "compe".setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
        vim_dadbod_completion = true;
    }
}
-- }}}

-- vim-test.vim {{{
vim.api.nvim_command("let test#strategy = 'basic'")
-- vim.api.nvim_command("let test#neovim#term_position = 'vert'")
-- vim.api.nvim_command("let test#ruby#rails#executable = 'dip rspec'")
-- vim.api.nvim_command("let test#ruby#rspec#executable = 'dip rspec'")
vim.api.nvim_command("let test#ruby#rspec#executable = 'DATABASE_URL=postgres://xfyuan:@localhost:5432/lb_esop_test bundle exec rspec'")
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
