return {
  --  +------------------------------------------------------------------------------+
  --  |                              Basic enhencement                               |
  --  +------------------------------------------------------------------------------+
  -- Range, pattern and substitute preview tool
  "xtal8/traces.vim",
  -- Better quickfix window in Neovim
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  -- Improved UI and workflow for the quickfix
  {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    opts = {},
  },
  -- Search and Replace using the full power of rg
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {
      keymaps = {
        close = { n = 'q' },
      },
    },
    keys = {
      { "<leader>rr", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>'), paths = vim.fn.expand('%') } })<cr>", desc = "Replace cursor word in current file" },
      { "<leader>rg", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<cr>", desc = "Replace cursor word" },
      { "<leader>rf", "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Replace in current file" },
      {
        "<leader>R",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  -- A better user experience for viewing and interacting with Vim marks
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
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
        delete = { text = "" },
        topdelete = { text = "" },
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
    opts = {
      hooks = {
        view_opened = function()
          require("diffview.actions").toggle_files()
        end,
      },
    },
    keys = {
      { "<leader>df", "<cmd>DiffviewOpen -uno<cr>", desc = "Open DiffView" },
      { "<leader>dq", "<cmd>DiffviewClose<cr>", desc = "Quit DiffView" },
      { "<leader>dp", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle DiffView file panel" },
    },
  },
  -- generate shareable file permalinks (with line ranges) for several git web frontend hosts
  {
    "ruifm/gitlinker.nvim",
    config = true,
    keys = {
      { "<leader>gY", "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>", desc = "Flash", mode = { "v" }, },
    },
  },
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
  -- Auto-Focusing and Auto-Resizing Splits/Windows
  {
    "nvim-focus/focus.nvim",
    keys = {
      { "<leader>wf", "<cmd>FocusToggle<cr>", desc = "Toggle window focus" },
      { "<leader>wl", "<cmd>FocusToggleBuffer<cr>", desc = "Toggle lock window size on buffer" },
      { "<leader>ws", "<cmd>FocusSplitNicely<cr>", desc = "Split a window on golden ratio" },
    },
    config = function()
      require("focus").setup({
        ui = {
          signcolumn = false,
        },
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
  -- displays the keys you are typing
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    keys = {
      { "<leader>K", "<cmd>Screenkey<cr>", desc = "Screenkey Toggle" },
    },
    opts = {
      win_opts = {
        -- row = 3,
        col = vim.o.columns * 0.5 + 20,
        height = 1,
        border = 'rounded',
      },
      group_mappings = true,
    },
  },
}
