local cmp = require('cmp')
local mapping = cmp.mapping
local api = vim.api

local default_sources = {
  snippets = { name = 'vsnip', keyword_length = 2, max_item_count = 6 },
  treesitter = { name = 'treesitter', keyword_length = 2, max_item_count = 6 },
  lsp = { name = 'nvim_lsp', keyword_length = 2, max_item_count = 10 },
  lua = { name = 'nvim_lua', keyword_length = 2, max_item_count = 6 },
  buffer = {
    name = 'buffer',
    keyword_length = 3,
    max_item_count = 5,
    option = { get_bufnrs = api.nvim_list_bufs },
  },
  spell = { name = 'spell', keyword_length = 3, max_item_count = 5 },
  path = { name = 'path', max_item_count = 10 },
}

local sources_for = function(names)
  return vim.tbl_map(function(name)
    return default_sources[name]
  end, names)
end

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,preview',
  },

  documentation = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  },

  formatting = {
    format = function(entry, vim_item)
      local icon = require('lspkind').presets.default[vim_item.kind]
      vim_item.kind = string.format('%s %s', icon, vim_item.kind)

      vim_item.menu = ({
        buffer = '',
        vsnip = '',
        nvim_lsp = '',
        nvim_lua = '',
        path = 'פּ',
        spell = '暈',
        treesitter = '',
      })[entry.source.name]

      return vim_item
    end,
  },

  mapping = {
    ['<C-d>'] = mapping.scroll_docs(-4),
    ['<C-f>'] = mapping.scroll_docs(4),
    ['<C-n>'] = mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    -- ['<down>'] = mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    -- ['<up>'] = mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    -- ['<c-space>'] = mapping.complete(),
    -- ['<c-e>'] = mapping.close(),
    ['<C-j>'] = cmp.mapping.confirm({ select = false }),
  },

  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  sources = sources_for({
    'lsp',
    'snippets',
    'treesitter',
    'buffer',
    'spell',
    'path',
  }),
})
