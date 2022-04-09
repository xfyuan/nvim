local cmd = vim.cmd
local g = vim.g

cmd "syntax on"

require('nightfox').setup {
  groups = {
    CursorLine = { bg = 'palette.bg2' },
  }
}
-- cmd('colorscheme nordfox')
-- g.tokyonight_style = "storm"
-- g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- cmd('colorscheme tokyonight')
cmd('colorscheme everforest')

-- hide line numbers , statusline in specific buffers!
vim.api.nvim_exec(
    [[
   au BufEnter term://* setlocal nonumber
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
   au BufEnter term://* set laststatus=0
]],
    false
)

-- indent-blankline.nvim
require("indent_blankline").setup {
  buftype_exclude = {"terminal", "telescope", "nofile"},
  filetype_exclude = {"help", "alpha", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float", ""},
  show_current_context = true,
  show_current_context_start = false,
  show_end_of_line = false,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  space_char_blankline = " ",
  use_treesitter = true,
}

-- nvim-colorizer.lua
require('colorizer').setup(
  {'*';},
  {
    RGB      = true;         -- #RGB hex codes
    RRGGBB   = true;         -- #RRGGBB hex codes
    names    = true;         -- "Name" codes like Blue
    RRGGBBAA = true;         -- #RRGGBBAA hex codes
    rgb_fn   = true;         -- CSS rgb() and rgba() functions
    hsl_fn   = true;         -- CSS hsl() and hsla() functions
    css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
  }
)

-- Misc
require("neoscroll").setup()
