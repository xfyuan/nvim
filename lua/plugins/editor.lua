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
  --
  { "mg979/vim-visual-multi", event = "BufReadPre" },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/flit.nvim",
    keys = function()
      local ret = {}
      for _, key in ipairs { "f", "F", "t", "T" } do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    event = "BufReadPre",
    opts = {
      safe_labels = {},
    },
    config = function(_, opts)
      local leap = require "leap"
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings()
      -- Remove default key mapping `s/S/x/X`, I CAN'T LIVE WITHOUT `s/S`!!
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
      vim.keymap.del({ "x", "o", "n" }, "s")
      vim.keymap.del({ "x", "o", "n" }, "S")
      -- Add custome key mapping `zj/zk`
      vim.keymap.set('n', '<leader>jj', '<Plug>(leap-forward)', {})
      vim.keymap.set('n', '<leader>jk', '<Plug>(leap-backward)', {})
    end,
  },
  -- preview markdown on your modern browser with synchronised scrolling
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
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
        autoresize = true,
        signcolumn = false,
        number = false,
        compatible_filetrees = {'nvimtree', 'neo-tree'}
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
  -- align text by split chars, defaut hotkey: ga/gA
  {
    "echasnovski/mini.align",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },
}
