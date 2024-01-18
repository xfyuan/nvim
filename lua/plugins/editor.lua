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
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  --  +------------------------------------------------------------------------------+
  --  |                                Motion moving                                 |
  --  +------------------------------------------------------------------------------+
  -- Neovim motions on speed! An EasyMotion-like plugin allowing you to jump anywhere in a document
  {
    "phaazon/hop.nvim",
    event = "BufReadPre",
    config = true,
    keys = {
      { "<leader>jj", "<cmd>HopWord<cr>", desc = "Hop word" },
      { "<leader>jc", "<cmd>HopChar2<cr>", desc = "Hop 2 char" },
      { "<leader>jl", "<cmd>HopLine<cr>", desc = "Hop line" },
    },
  },
  -- Navigate your code with search labels, enhanced character motions and Treesitter integration
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {
      modes = {
        search = {
          enabled = false,
        },
        char = {
          enabled = true,
          keys = { "f", "F" },
          search = { wrap = false },
          highlight = { backdrop = true },
          jump = { register = false },
        },
      },
    },
    keys = {
      { "<leader>jf", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
      { "<leader>jt", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
    },
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
  -- {
  --   "akinsho/git-conflict.nvim",
  --   version = "*",
  --   config = true,
  -- },
  -- generate shareable file permalinks (with line ranges) for several git web frontend hosts
  -- {
  --   "ruifm/gitlinker.nvim",
  --   config = true,
  -- },
  -- A range and area selectable :Diffthis to compare partially
  {
    "rickhowe/spotdiff.vim",
    event = { "BufReadPost", "BufNewFile" },
  },
  --  +------------------------------------------------------------------------------+
  --  |                                   Windows                                    |
  --  +------------------------------------------------------------------------------+
  -- Easily jump between NeoVim windows
  {
    "yorickpeterse/nvim-window",
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
    "nvim-focus/focus.nvim",
    commit = 'a994282f',
    event = "VeryLazy",
    config = function()
      require("focus").setup({
        ui = {
          signcolumn = false,
        },
      })
    end,
  },
--  +------------------------------------------------------------------------------+
--  |                                   Markdown                                   |
--  +------------------------------------------------------------------------------+
  -- preview markdown on your modern browser with synchronised scrolling
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
  },
  -- {
  --   "Zeioth/markmap.nvim",
  --   build = "yarn global add markmap-cli",
  --   cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
  --   config = true,
  -- },
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
