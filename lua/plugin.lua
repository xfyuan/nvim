local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  -- ============ Appearance ============ -- {{{
  {
    "goolord/alpha-nvim", -- a fast and fully programmable greeter
    config = function()
      require('plugins.config.alpha-nvim')
    end,
    },
  {
    "nvim-lualine/lualine.nvim", -- A blazing fast and easy to configure statusline
    config = function()
      require('plugins.config.lualine')
    end,
  },
  "norcalli/nvim-colorizer.lua", -- A high-performance color highlighter
  "lukas-reineke/indent-blankline.nvim", -- adds indentation guides to all lines
  {
    "karb94/neoscroll.nvim", -- a smooth scrolling neovim plugin
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-d>", "<C-b>", "<C-f>", "<C-e>", "zt", "zz", "zb" },
      })
    end,
  },
  -- Themes
  "xfyuan/nightforest.nvim",
  "sainnhe/everforest",
  "EdenEast/nightfox.nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },
  -- }}}

  -- ============ Core ============ -- {{{
  "folke/which-key.nvim", -- create keybindings and displays a popup with possible keybindings
  "kyazdani42/nvim-tree.lua", -- A file explorer tree for neovim written in lua
  "yianwillis/vimcdoc",
  { "milisims/nvim-luaref", event = "BufReadPre" }, -- Add a vim :help reference for lua
  {
    "rcarriga/nvim-notify", -- A fancy, configurable, notification manager
    config = function()
      require('plugins.config.notify')
    end,
  },
  {
    "rmagatti/auto-session", -- Auto Session takes advantage of Neovim's existing session management capabilities to provide seamless automatic session management
    dependencies = { "rmagatti/session-lens" },
    config = function()
      require("session-lens").setup({})
      require("auto-session").setup({
        auto_session_root_dir = vim.fn.stdpath("config") .. "/sessions/",
        auto_session_enabled = false,
        pre_save_cmds = { "NvimTreeClose" },
        post_restore_cmds = { "NvimTreeOpen" },
      })
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",
    enabled = true,
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = false,
        }
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
  {
    "phaazon/hop.nvim", -- Neovim motions on speed! An EasyMotion-like plugin allowing you to jump anywhere in a document
    config = function()
      require("hop").setup()
    end,
  },
  {
    "echasnovski/mini.bufremove", -- Delete Neovim buffers without losing window layout
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    "echasnovski/mini.jump", -- Extended f, F, t and T key mappings
    opts = {
      mappings = {
        repeat_jump = '',
      },
    },
    keys = { "f", "F", "t", "T" },
    config = function(_, opts)
      require("mini.jump").setup(opts)
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  "ethanholz/nvim-lastplace", -- Intelligently reopen files at your last edit position in Vim
  -- use 'dyng/ctrlsf.vim' -- A powered code search and view tool
  "windwp/nvim-spectre", -- Find the enemy and replace them with dark power
  "xtal8/traces.vim", -- Range, pattern and substitute preview tool
  "akinsho/toggleterm.nvim", -- A neovim lua plugin to help easily manage multiple terminal windows
  "voldikss/vim-translator", -- Asynchronous translating plugin
  { "kevinhwang91/nvim-bqf", ft = "qf" }, -- Better quickfix window in Neovim
  "sindrets/diffview.nvim", -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
  {
    "beauwilliams/focus.nvim", -- Auto-Focusing and Auto-Resizing Splits/Windows
    config = function()
      require("focus").setup({
        autoresize = false,
        signcolumn = false,
        number = false,
      })
    end,
  },
  {
    "potamides/pantran.nvim", -- Use your favorite machine translation engines without having to leave your favorite editor
    config = function()
      require("pantran").setup({
        default_engine = "google",
      })
      local opts = { noremap = true, silent = true, expr = true }
      vim.keymap.set("n", "<leader>tr", function()
        return require("pantran").motion_translate() .. "_"
      end, opts)
      vim.keymap.set("x", "<leader>tr", require("pantran").motion_translate, opts)
    end,
  },
  {
    "axieax/urlview.nvim", -- viewing all the URLs in a buffer
    config = function()
      require("urlview").setup({
        default_picker = "telescope",
      })
    end,
  },
  {
    "https://gitlab.com/yorickpeterse/nvim-window.git", -- Easily jump between NeoVim windows
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
  {
    "kevinhwang91/nvim-ufo", -- make Neovim's fold look modern and keep high performance
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require('plugins.config.ufo')
    end,
  },
  {
    "akinsho/git-conflict.nvim", -- visualise and resolve merge conflicts in neovim
    version = "*",
    config = function()
      require("git-conflict").setup()
    end,
  },
  {
    "ruifm/gitlinker.nvim", -- generate shareable file permalinks (with line ranges) for several git web frontend hosts
    config = function()
      require("gitlinker").setup()
    end,
  },
  {
    "folke/todo-comments.nvim", -- Highlight, list and search todo comments in codebase
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "chentoast/marks.nvim", -- A better user experience for viewing and interacting with Vim marks
    event = "BufReadPre",
    config = function()
      require("marks").setup({})
    end,
  },
  {
    "abecodes/tabout.nvim", -- Supercharge your workflow and start tabbing out from parentheses, quotes, and similar contexts
    event = "VeryLazy",
    config = function()
      require("tabout").setup({
        completion = false,
        ignore_beginning = true,
      })
    end,
  },
  {
    "kevinhwang91/nvim-hlslens", -- helps you better glance at matched information, seamlessly jump between matched instances.
    branch = "main",
    keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
    config = function()
      require('plugins.config.hlslens')
    end
  },

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-symbols.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "tsakirist/telescope-lazy.nvim" },
      { "crispgm/telescope-heading.nvim" },
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
  "mg979/vim-visual-multi",
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
  },

  -- Text Objects
  {
    "kana/vim-textobj-user", -- Create your own text objects
    dependencies = {
      { "kana/vim-textobj-line" }, -- al | il
      { "kana/vim-textobj-indent" }, -- ai | ii
      { "glts/vim-textobj-comment" }, -- ac/ic for a comment
      { "sgur/vim-textobj-parameter" }, -- a,/i, for function argument
    },
  },
  -- }}}

  -- ============ Legend ============ -- {{{
  -- Tim Pope ⭐
  "tpope/vim-fugitive",
  "tpope/vim-unimpaired", -- pairs of handy bracket mappings, like ]n jumpt to SCM conflict
  "tpope/vim-sleuth", -- automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
  "tpope/vim-abolish", -- switch case using crc, crs, crm, etc.
  "tpope/vim-rails",
  {
    "tpope/vim-dadbod",
    dependencies = {
      { "kristijanhusak/vim-dadbod-ui" },
      { "kristijanhusak/vim-dadbod-completion" },
    },
  },
  {
    "tpope/vim-surround",
    "wellle/targets.vim", -- provides additional powerfull text objects!!
  },

  -- Junegunn Choi ⭐
  { 'junegunn/fzf', build = ":call fzf#install()" },
  { 'junegunn/fzf.vim' },
  "junegunn/vim-fnr", -- Find-N-Replace in Vim with live preview
  "junegunn/gv.vim",
  -- CONFLICT with hlslens plugin, so disable it 👇
  -- use 'junegunn/vim-slash' -- automatically clearing Vim's search highlighting whenever the cursor moves or insert mode is entered
  -- }}}

  -- ============ Programming ============ -- {{{
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/playground" },
      { "RRethy/nvim-treesitter-textsubjects" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "lewis6991/spellsitter.nvim" },
      {
        "romgrk/nvim-treesitter-context",
        config = function()
          require("treesitter-context").setup()
        end,
      },
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
      {
        "RRethy/nvim-treesitter-endwise",
        config = function()
          require("nvim-treesitter.configs").setup({
            endwise = {
              enable = true,
            },
          })
        end,
      },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp").setup()
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "jose-elias-alvarez/typescript.nvim",
      "folke/neodev.nvim",
      "ray-x/lsp_signature.nvim",
      "haringsrob/nvim_context_vt",
      {
        "SmiteshP/nvim-navic", -- A simple statusline/winbar component that uses LSP to show your current code context.
        config = function()
          require("nvim-navic").setup({})
        end,
      },
      {
        "simrat39/inlay-hints.nvim",
        config = function()
          require("inlay-hints").setup()
        end,
      },
      {
        "j-hui/fidget.nvim", -- Standalone UI for nvim-lsp progress
        config = function()
          require("fidget").setup({})
        end,
      },
      {
        "folke/trouble.nvim", -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
        config = function()
          require("trouble").setup({})
        end,
      },
    },
  },

  -- LSP Powerfull Plugins
  {
    "stevearc/aerial.nvim", -- A code outline window for skimming and quick navigation
    config = function()
      require("aerial").setup({
        manage_folds = true,
        link_folds_to_tree = true,
        link_tree_to_folds = true,
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
    end,
  },
  {
    "glepnir/lspsaga.nvim", -- A light-weight lsp plugin based on neovim's built-in lsp with a highly performant UI.
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          in_custom = false,
        },
      })
    end,
  },
  {
    "ray-x/go.nvim",
    config = function()
      require("go").setup()
    end,
  },

  -- Debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "⛔", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })
      -- vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
      -- vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='', linehl='', numhl=''})
      -- vim.fn.sign_define('DapLogPoint', {text='ﱴ', texthl='', linehl='', numhl=''})
      -- vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='', numhl=''})
      -- vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='', linehl='', numhl=''})
      require("dapui").setup({
        mappings = {
          expand = { "o", "<2-LeftMouse>" },
          open = "<CR>",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
      })
      require("nvim-dap-virtual-text").setup({})
      require("dap-go").setup()
      require("dap.ext.vscode").load_launchjs()
    end,
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "f3fora/cmp-spell",
      "onsails/lspkind-nvim",
      "ray-x/cmp-treesitter",
      "lukas-reineke/cmp-under-comparator",
    },
    config = function()
      require('plugins.config.cmp')
    end
  },
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "quoyi/rails-vscode",
      "benfowler/telescope-luasnip.nvim",
    },
  },

  -- Enhancement Plugins
  "zackhsi/fzf-tags",
  "lewis6991/gitsigns.nvim",
  "rizzatti/dash.vim",
  "LudoPinelli/comment-box.nvim",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    config = function()
      require("refactoring").setup {
        prompt_func_return_type = { js = true, ts = true, go = true, ruby = true, },
        prompt_func_param_type = { js = true, ts = true, go = true, ruby = true, },
      }
      require("telescope").load_extension "refactoring"
    end,
  },

  "vim-test/vim-test", -- test running tool for many languages
  "AndrewRadev/splitjoin.vim", -- Switch between single-line and multiline forms of code: gS to split a one-liner into multiple lines. gJ (with the cursor on the first line of a block) to join a block into a single-line.
  "AndrewRadev/switch.vim", -- switch segments of text with predefined replacements. default mapping `gs` to trigger the command
  "kg8m/vim-simple-align",
  -- "buoto/gotests-vim", -- generate go table driven tests easily
  -- }}}
}, {
  concurrency = 24,
  ui = { border = "rounded", }
})
