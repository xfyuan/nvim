-- Setup nvim-cmp.
local cmp = require "cmp"
local luasnip = require("luasnip")
require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({paths = {vim.fn.stdpath('config') .. '/snippets'}})

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
               and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                   col, col):match("%s") == nil
end

cmp.setup({
    view = {
      entries = {name = 'custom', selection_order = 'near_cursor' }
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
      format = function(entry, vim_item)
        local icon = require('lspkind').presets.default[vim_item.kind]
        vim_item.kind = string.format('%s %s', icon, vim_item.kind)

        vim_item.menu = ({
          buffer = '',
          emoji = '',
          vsnip = '',
          nvim_lsp = '',
          nvim_lua = '',
          path = 'פּ',
          calc = '',
          spell = '暈',
          treesitter = '',
        })[entry.source.name]

        return vim_item
      end,
    },
    experimental = {native_menu = false, ghost_text = false},
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-l>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i", "s"}),
        ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, {"i", "s"})
    },
    sources = {
        {name = "nvim_lsp"},
        {name = 'nvim_lua'},
        {name = 'treesitter'},
        {name = "buffer", keyword_length = 5},
        {name = "luasnip"},
        {name = "calc"},
        {name = "emoji"},
        {name = "spell"},
        {name = "path"},
        {name = 'nvim_lsp_signature_help'},
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require "cmp-under-comparator".under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})
-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})
