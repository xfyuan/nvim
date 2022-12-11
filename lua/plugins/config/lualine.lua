local lualine = require('lualine')
local navic = require("nvim-navic")

local bufnr = function()
  return tostring(vim.api.nvim_get_current_buf())
end
local spacer = function()
  return ' '
end

local filename = {
  'filename',
  file_status = true,
  path = 1,
  shorting_target = 40,
  symbols = { modified = ' +', readonly = ' ' },
}

lualine.setup({
  extensions = { "nvim-tree", "quickfix", "fugitive", "aerial", "toggleterm" },
  options = {
    theme = 'auto',
    icons_enabled = true,
    -- section_separators = '',
    section_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},

    component_separators = '',
    -- component_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
  },
  tabline = {
    lualine_a = {},
    lualine_b = {'branch'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {{ 'tabs', mode = 2, tabs_color = { active = 'TSNote' } }},
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        bufnr,
        separator = '│',
      },
      {
        spacer,
        padding = 0,
      },
      {
        'filetype',
        colored = true,
        icon_only = true,
        padding = 0,
      },
      filename,
    },
    lualine_c = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = {
          error = '',
          warn = '',
          hint = '',
          info = '',
        },
        color_error = '#CA1243',
        color_warn = '#F7C154',
        color_hint = '#50A14F',
        color_info = '#6699CC',
      },
      { navic.get_location, cond = navic.is_available },
    },
    lualine_x = {
      {
        'encoding',
        padding = 0,
        separator = ' ',
      },
      {
        'fileformat',
        padding = 0,
      },
      {
        spacer,
        padding = 0,
      },
    },
    lualine_y = { 'diff' },
    lualine_z = {
      { '[[%3l:%-3c]]' },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { bufnr },
    lualine_c = { filename },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
