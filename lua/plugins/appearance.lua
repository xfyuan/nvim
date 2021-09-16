local cmd = vim.cmd
local g = vim.g

-- top buffer lines {{{
-- require "bufferline".setup {
--     options = {
--         offsets = {{filetype = "NvimTree", text = "", padding = 1}},
--         buffer_close_icon = "",
--         modified_icon = "",
--         close_icon = "",
--         left_trunc_marker = "",
--         right_trunc_marker = "",
--         max_name_length = 14,
--         max_prefix_length = 13,
--         tab_size = 20,
--         show_tab_indicators = true,
--         enforce_regular_tabs = false,
--         view = "multiwindow",
--         show_buffer_close_icons = true,
--         separator_style = "thin",
--         mappings = "true"
--     }
-- }
-- }}}

cmd "syntax on"

require("colorizer").setup()
require("neoscroll").setup()

-- blankline

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false
