return {
  --  +------------------------------------------------------------------------------+
  --  |                              Basic enhencement                               |
  --  +------------------------------------------------------------------------------+
  -- Range, pattern and substitute preview tool
  "xtal8/traces.vim",
  -- Better quickfix window in Neovim
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    keys = {
      { "<leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", desc = "Replace cursor word" },
      { "<leader>rf", "viw:lua require('spectre').open_file_search()<cr>", desc = "Replace in current file" },
      { "<leader>ro", "<cmd>lua require('spectre').open()<CR>", desc = "Replace in files" },
    },
  },

  -- A better user experience for viewing and interacting with Vim marks
  {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    config = true,
    keys = {
      { "<leader>mb", "<cmd>MarksListBuf<cr>", desc = "Find Mark in buffer" },
      { "<leader>ma", "<cmd>MarksListAll<cr>", desc = "Find Mark in all buffers" },
    },
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
  -- automatically disables certain features if the opened file is big
  {
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    config = function()
      local cmp = {
        name = "nvim-cmp",
        opts = { defer = true },
        disable = function()
          require("cmp").setup.buffer({ enabled = false })
        end,
      }

      require("bigfile").setup {
        filesize = 1, -- size of the file in MiB
        pattern = { "*" },
        features = { -- features to disable
          "indent_blankline",
          "illuminate",
          "treesitter",
          "matchparen",
          "vimopts",
          -- "lsp",
          "syntax",
          "filetype",
          cmp,
        },
      }
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
      { "<leader>jf", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash", },
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
    keys = {
      { "<leader>hb", "<cmd>lua require 'gitsigns'.blame_line({ full = true })<cr>", desc = "Blame Line" },
      { "<leader>hB", "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", desc = "Toggle line blame" },
      { "<leader>hd", "<cmd>lua require 'gitsigns'.diffthis()<cr>", desc = "Diff This" },
      { "<leader>hD", "<cmd>lua require 'gitsigns'.diffthis('~')<cr>", desc = "Diff This ~" },
      { "<leader>hj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk" },
      { "<leader>hk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk" },
      { "<leader>hs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
      { "<leader>hr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
      { "<leader>hu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
      { "<leader>hS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", desc = "Stage Buffer" },
      { "<leader>hR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
      { "<leader>hp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
    },
  },
  -- single tabpage interface for easily cycling through diffs for all modified files
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
    keys = {
      { "<leader>df", "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close DiffView" },
    },
  },
  -- visualise and resolve merge conflicts in neovim
  -- {
  --   "akinsho/git-conflict.nvim",
  --   version = "*",
  --   config = true,
  -- },
  -- generate shareable file permalinks (with line ranges) for several git web frontend hosts
  {
    "ruifm/gitlinker.nvim",
    config = true,
    keys = {
      { "<leader>gY", "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>", desc = "Flash", mode = { "v" }, },
    },
  },
  -- A range and area selectable :Diffthis to compare partially
  -- {
  --   "rickhowe/spotdiff.vim",
  --   event = { "BufReadPost", "BufNewFile" },
  -- },
  --  +------------------------------------------------------------------------------+
  --  |                                   Windows                                    |
  --  +------------------------------------------------------------------------------+
  -- Easily jump between NeoVim windows
  {
    "yorickpeterse/nvim-window",
    keys = {
      { "<leader>wp", "<cmd>lua require('nvim-window').pick()<cr>", desc = "Pick window" },
    },
    config = function()
      vim.cmd([[hi BlackOnLightYellow guifg=#000000 guibg=#f2de91]])
      require("nvim-window").setup({
        chars = { "a", "s", "f", "g", "h", "j", "k", "l" },
        hint_hl = "Bold",
      })
    end,
  },
  -- Toggle maximize window
  {
    "declancm/maximize.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>ww", "<cmd>lua require('maximize').toggle()<cr>", desc = "Toggle window max" },
    },
  },
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    keys = {
      { "<leader>wz", "<cmd>ZenMode<cr>", desc = "Toggle zen mode" },
      { '<leader>wd', "<cmd>Twilight<cr>", desc = "Toggle dim state" }
    },
    opts = {
      window = {
        backdrop = 1,
        width = 0.70,
      },
      on_open = function(win)
        vim.opt["conceallevel"] = 3
        vim.opt["concealcursor"] = "nc"
      end,
      on_close = function()
        vim.opt["conceallevel"] = 0
        vim.opt["concealcursor"] = ""
      end,
    },
  },
--  +------------------------------------------------------------------------------+
--  |                                   Markdown                                   |
--  +------------------------------------------------------------------------------+
  -- preview markdown on your modern browser with synchronised scrolling
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
    keys = {
      { "<leader>wm", "<cmd>MarkdownPreview<cr>", desc = "Open markdown preview window" },
    },
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
    keys = {
      { "<leader>ll", "<cmd>UrlView buffer<cr>", desc = "Find URL and open" },
      { "<leader>lc", "<cmd>UrlView buffer action=clipboard<cr>", desc = "Find URL and copy" },
    },
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
