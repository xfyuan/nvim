vim.cmd(([[autocmd FileType markdown lua whichkey_markdown()]]))

_G.whichkey_markdown = function()
  local Util = require("util")
  local wk = require("which-key")
  wk.add({
    { "<tab>", function() Util.markdown_next_link() end, desc = "Next heading or link" },
    { "<leader>m", group = "Markdown" },
    { "<leader>mh", "<cmd>Telescope heading<cr>", desc = "Jump markdown heading" },
    { "<leader>mc", function() Util.markdown_insert_codeblock() end, desc = "Insert code block" },
    { "<leader>mj", function() Util.markdown_next_link() end, desc = "Next heading or link" },
    { "<leader>mk", function() Util.markdown_prev_link() end, desc = "Prev heading or link" },
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
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Open markdown preview window", ft = "markdown" },
    },
  },
  -- improve viewing Markdown files
  {
    'MeanderingProgrammer/markdown.nvim',
    ft = "markdown",
    name = 'render-markdown',
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown render preview", ft = "markdown" },
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
