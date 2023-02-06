return {
  --  +------------------------------------------------------------------------------+
  --  |                              Basic enhencement                               |
  --  +------------------------------------------------------------------------------+
  -- Range, pattern and substitute preview tool
  "xtal8/traces.vim",
  -- Better quickfix window in Neovim
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  -- search/replace in multiple files
  { "windwp/nvim-spectre" },

  -- A better user experience for viewing and interacting with Vim marks
  {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    config = true,
  },
  -- new generation multiple cursors plugin,
  -- select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
  -- create cursors vertically with Ctrl-Down/Ctrl-Up
  -- select one character at a time with Shift-Arrows
  -- press n/N to get next/previous occurrence
  -- press [/] to select next/previous cursor
  -- press q to skip current and get next occurrence
  -- press Q to remove current cursor/selection
  { "mg979/vim-visual-multi", event = "BufReadPre" },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
    end,
  },
  -- preview markdown on your modern browser with synchronised scrolling
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
  },
  --  +------------------------------------------------------------------------------+
  --  |                                     Git                                      |
  --  +------------------------------------------------------------------------------+
  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },
  -- single tabpage interface for easily cycling through diffs for all modified files
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
  },
  -- visualise and resolve merge conflicts in neovim
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },
  -- generate shareable file permalinks (with line ranges) for several git web frontend hosts
  {
    "ruifm/gitlinker.nvim",
    config = true,
  },
  --  +------------------------------------------------------------------------------+
  --  |                                   Windows                                    |
  --  +------------------------------------------------------------------------------+
  -- Easily jump between NeoVim windows
  {
    "https://gitlab.com/yorickpeterse/nvim-window.git",
    config = function()
      vim.cmd([[hi BlackOnLightYellow guifg=#000000 guibg=#f2de91]])
      require("nvim-window").setup({
        chars = { "a", "s", "f", "g", "h", "j", "k", "l" },
        normal_hl = "BlackOnLightYellow",
        hint_hl = "Bold",
        border = "none",
      })
    end,
  },
  -- Auto-Focusing and Auto-Resizing Splits/Windows
  {
    "beauwilliams/focus.nvim",
    event = "VeryLazy",
    config = function()
      require("focus").setup({
        autoresize = false,
        signcolumn = false,
        number = false,
      })
    end,
  },
  --  +------------------------------------------------------------------------------+
  --  |                                    Extras                                    |
  --  +------------------------------------------------------------------------------+
  -- viewing all the URLs in a buffer
  {
    "axieax/urlview.nvim",
    event = "VeryLazy",
    config = function()
      require("urlview").setup({
        default_picker = "telescope",
      })
    end,
  },
}
