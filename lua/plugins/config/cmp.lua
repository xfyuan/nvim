-- Setup nvim-cmp.
local cmp = require "cmp"

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
               and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                   col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                          mode, true)
end

cmp.setup({
    documentation = {
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
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
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i", "s"}),
        ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, {"i", "s"})
    },
    sources = {
        {name = "nvim_lsp"},
        {name = 'nvim_lua'},
        {name = 'treesitter'},
        {name = "buffer", keyword_length = 5},
        {name = "vsnip"},
        {name = "calc"},
        {name = "emoji"},
        {name = "spell"},
        {name = "path"},
    }
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})
