local treesitter = require('nvim-treesitter.configs')
local spellsitter = require('spellsitter')

-- vim-matchup plugin, uses treesitter
-- Do not show the not visible matching context on statusline
vim.g.matchup_matchparen_offscreen = {}

treesitter.setup({
  ensure_installed = {
    'bash', 'cmake', 'css', 'dockerfile', 'eex', 'elixir', 'erlang',
    'go', 'gomod', 'html', 'heex', 'help', 'http', 'markdown',
    'javascript', 'jsdoc', 'json', 'lua', 'regex', 'ruby', 'scss',
    'toml', 'tsx', 'typescript', 'vim', 'vue', 'yaml',
  },
  ignore_install = { 'kotlin', 'java' },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { 'ruby' },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = 'gnn',
      node_decremental = 'gnm',
    },
  },
  context_commentstring = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'rounded',
      peek_definition_code = {
        ["<leader>da"] = "@function.outer",
        ["<leader>dA"] = "@class.outer",
      },
    },
  },
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
    navigation = { enable = true },
    smart_rename = { enable = true },
  },
  matchup = {
    enable = true,
  },
  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = false,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { 'BufWrite', 'CursorHold' },
  },
})

spellsitter.setup({
  hl = 'SpellBad',
  captures = { 'comment', 'string' },
})
