vim.cmd(([[autocmd FileType markdown lua whichkey_markdown()]]))

_G.whichkey_markdown = function()
  local Util = require("util")
  local wk = require("which-key")
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["<tab>"] = {function() Util.markdown_next_link() end, "Next heading or link", buffer = buf },
    ["<leader>m"] = {
      name = "Markdown",
      j = { function() Util.markdown_next_link() end, "Next heading or link", buffer = buf },
      k = { function() Util.markdown_prev_link() end, "Prev heading or link", buffer = buf },
      c = { function() Util.markdown_insert_codeblock() end, "Insert code block", buffer = buf },
      t = { function() Util.markdown_todo_toggle() end, "Toggle todo", },
    },
  })
end

return {
--  +------------------------------------------------------------------------------+
--  |                                   Markdown                                   |
--  +------------------------------------------------------------------------------+
  -- preview markdown on your modern browser with synchronised scrolling
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
    keys = {
      { "<leader>wm", "<cmd>MarkdownPreview<cr>", desc = "Open markdown preview window", ft = "markdown" },
    },
  },
  -- improve viewing Markdown files
  {
    'MeanderingProgrammer/markdown.nvim',
    ft = "markdown",
    name = 'render-markdown',
    keys = {
      { "<leader>um", "<cmd>RenderMarkdownToggle<cr>", desc = "Toggle markdown render preview", ft = "markdown" },
    },
    config = function()
      require('render-markdown').setup({})
    end,
  },
  -- keymaps for toggling text formatting
  --<C-k>: Adds a link to visually selected text.
  -- <C-b>: Toggles visually selected text to bold.
  -- <C-i>: Toggles visually selected text to italic.
  -- <C-e>: Toggles visually selected text to inline code
  {
    'antonk52/markdowny.nvim',
    ft = "markdown",
    config = true,
  },
  -- {
  --   "Zeioth/markmap.nvim",
  --   build = "yarn global add markmap-cli",
  --   cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
  --   config = true,
  -- },
}
