local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end

local packer = require("packer")
local use = packer.use

return packer.startup({
  function()
    use("lewis6991/impatient.nvim")
    use("wbthomason/packer.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("kyazdani42/nvim-web-devicons")

    -- ============ Appearance ============ -- {{{
    use({
      "goolord/alpha-nvim", -- a fast and fully programmable greeter
      config = [[require('plugins.config.alpha-nvim')]],
    })
    use({
      "nvim-lualine/lualine.nvim", -- A blazing fast and easy to configure statusline
      config = [[require('plugins.config.lualine')]],
    })
    use("norcalli/nvim-colorizer.lua") -- A high-performance color highlighter
    use("lukas-reineke/indent-blankline.nvim") -- adds indentation guides to all lines
    use({
      "karb94/neoscroll.nvim", -- a smooth scrolling neovim plugin
      config = function()
        require("neoscroll").setup({
          mappings = { "<C-d>", "<C-b>", "<C-f>", "<C-e>", "zt", "zz", "zb" },
        })
      end,
    })
    -- Themes
    use("xfyuan/nightforest.nvim")
    use("sainnhe/everforest")
    use("folke/tokyonight.nvim")
    use("EdenEast/nightfox.nvim")
    use("Shatur/neovim-ayu")
    -- }}}

    -- ============ Core ============ -- {{{
    use("folke/which-key.nvim") -- create keybindings and displays a popup with possible keybindings
    use("kyazdani42/nvim-tree.lua") -- A file explorer tree for neovim written in lua
    use("yianwillis/vimcdoc")
    use({ "milisims/nvim-luaref", event = "BufReadPre" }) -- Add a vim :help reference for lua
    use({
      "rcarriga/nvim-notify", -- A fancy, configurable, notification manager
      config = [[require('plugins.config.notify')]],
    })

    use({
      "rmagatti/auto-session", -- Auto Session takes advantage of Neovim's existing session management capabilities to provide seamless automatic session management
      requires = { "rmagatti/session-lens" },
      config = function()
        require("session-lens").setup({})
        require("auto-session").setup({
          auto_session_root_dir = vim.fn.stdpath("config") .. "/sessions/",
          auto_session_enabled = false,
          pre_save_cmds = { "NvimTreeClose" },
          post_restore_cmds = { "NvimTreeOpen" },
        })
      end,
    })
    use({
      "phaazon/hop.nvim", -- Neovim motions on speed! An EasyMotion-like plugin allowing you to jump anywhere in a document
      config = function()
        require("hop").setup()
      end,
    })
    use("ethanholz/nvim-lastplace") -- Intelligently reopen files at your last edit position in Vim
    -- use 'dyng/ctrlsf.vim' -- A powered code search and view tool
    use("windwp/nvim-spectre") -- Find the enemy and replace them with dark power
    use("rhysd/clever-f.vim") -- Extended f, F, t and T key mappings
    use("xtal8/traces.vim") -- Range, pattern and substitute preview tool
    use("akinsho/toggleterm.nvim") -- A neovim lua plugin to help easily manage multiple terminal windows
    use("voldikss/vim-translator") -- Asynchronous translating plugin
    use("famiu/bufdelete.nvim") -- Delete Neovim buffers without losing window layout
    use({ "kevinhwang91/nvim-bqf", ft = "qf" }) -- Better quickfix window in Neovim
    use("sindrets/diffview.nvim") -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    use({
      "beauwilliams/focus.nvim", -- Auto-Focusing and Auto-Resizing Splits/Windows
      config = function()
        require("focus").setup({
          autoresize = false,
          signcolumn = false,
          number = false,
        })
      end,
    })
    use({
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
    })
    use({
      "axieax/urlview.nvim", -- viewing all the URLs in a buffer
      config = function()
        require("urlview").setup({
          default_picker = "telescope",
        })
      end,
    })
    use({
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
    })
    use({
      "kevinhwang91/nvim-ufo", -- make Neovim's fold look modern and keep high performance
      requires = "kevinhwang91/promise-async",
      config = [[require('plugins.config.ufo')]],
    })
    use({
      "akinsho/git-conflict.nvim", -- visualise and resolve merge conflicts in neovim
      tag = "*",
      config = function()
        require("git-conflict").setup()
      end,
    })
    use({
      "ruifm/gitlinker.nvim", -- generate shareable file permalinks (with line ranges) for several git web frontend hosts
      config = function()
        require("gitlinker").setup()
      end,
    })
    use({
      "folke/todo-comments.nvim", -- Highlight, list and search todo comments in codebase
      config = function()
        require("todo-comments").setup()
      end,
    })
    use({
      "chentoast/marks.nvim", -- A better user experience for viewing and interacting with Vim marks
      event = "BufReadPre",
      config = function()
        require("marks").setup({})
      end,
    })
    use({
      "abecodes/tabout.nvim", -- Supercharge your workflow and start tabbing out from parentheses, quotes, and similar contexts
      after = { "nvim-cmp" },
      config = function()
        require("tabout").setup({
          completion = false,
          ignore_beginning = true,
        })
      end,
    })
    use({
      "kevinhwang91/nvim-hlslens", -- helps you better glance at matched information, seamlessly jump between matched instances.
      branch = "main",
      keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
      config = [[require('plugins.config.hlslens')]],
    })

    -- Fuzzy Finder
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "nvim-telescope/telescope-project.nvim" },
        { "nvim-telescope/telescope-packer.nvim" },
        { "nvim-telescope/telescope-dap.nvim" },
        { "crispgm/telescope-heading.nvim" },
      },
    })

    -- new generation multiple cursors plugin,
    -- select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
    -- create cursors vertically with Ctrl-Down/Ctrl-Up
    -- select one character at a time with Shift-Arrows
    -- press n/N to get next/previous occurrence
    -- press [/] to select next/previous cursor
    -- press q to skip current and get next occurrence
    -- press Q to remove current cursor/selection
    use("mg979/vim-visual-multi")
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      ft = "markdown",
    })

    -- Text Objects
    use("kana/vim-textobj-user") -- Create your own text objects
    use("kana/vim-textobj-line") -- al | il
    use("kana/vim-textobj-syntax") -- ay | iy
    use("kana/vim-textobj-indent") -- ai | ii
    use("kana/vim-textobj-lastpat") -- a/ | i/
    use("nelstrom/vim-textobj-rubyblock") -- ar | ir
    use("osyo-manga/vim-textobj-multiblock") -- ab | ib
    use("idbrii/textobj-word-column.vim") -- ac | ic
    use("Julian/vim-textobj-variable-segment") -- av | iv
    use("bootleq/vim-textobj-rubysymbol") -- a: | i:
    -- }}}

    -- ============ Legend ============ -- {{{
    -- Tim Pope ⭐
    use("tpope/vim-fugitive")
    use("tpope/vim-unimpaired") -- pairs of handy bracket mappings, like ]n jumpt to SCM conflict
    use("tpope/vim-sleuth") -- automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
    use("tpope/vim-abolish") -- switch case using crc, crs, crm, etc.
    use("tpope/vim-rails")
    use({
      "tpope/vim-dadbod",
      requires = {
        { "kristijanhusak/vim-dadbod-ui" },
        { "kristijanhusak/vim-dadbod-completion" },
      },
    })
    use({
      "tpope/vim-surround",
      "wellle/targets.vim", -- provides additional powerfull text objects!!
    })

    -- Junegunn Choi ⭐
    use({ "junegunn/fzf.vim", requires = { "junegunn/fzf", opt = true } })
    use("junegunn/vim-fnr") -- Find-N-Replace in Vim with live preview
    use("junegunn/gv.vim")
    -- CONFLICT with hlslens plugin, so disable it 👇
    -- use 'junegunn/vim-slash' -- automatically clearing Vim's search highlighting whenever the cursor moves or insert mode is entered
    -- }}}

    -- ============ Programming ============ -- {{{
    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
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
          "windwp/nvim-autopairs",
          config = function()
            require("nvim-autopairs").setup()
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
    })

    -- LSP
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("plugins.lsp").setup()
      end,
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        { "jose-elias-alvarez/typescript.nvim", module = { "typescript" } },
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
    })

    -- LSP Powerfull Plugins
    use({
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
    })
    use({
      "glepnir/lspsaga.nvim", -- A light-weight lsp plugin based on neovim's built-in lsp with a highly performant UI.
      config = function()
        require("lspsaga").init_lsp_saga({
          symbol_in_winbar = {
            in_custom = false,
          },
        })
      end,
    })
    use({
      "ray-x/go.nvim",
      config = function()
        require("go").setup()
      end,
    })

    -- Debugger
    use({
      "rcarriga/nvim-dap-ui",
      requires = {
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
    })
    -- Completion
    use({
      "hrsh7th/nvim-cmp",
      requires = {
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
      config = [[require('plugins.config.cmp')]],
    })
    -- snippets
    use({
      "L3MON4D3/LuaSnip",
      requires = {
        "rafamadriz/friendly-snippets",
        "quoyi/rails-vscode",
        "benfowler/telescope-luasnip.nvim",
      },
    })

    -- Enhancement Plugins
    use("zackhsi/fzf-tags")
    use("lewis6991/gitsigns.nvim")
    use("rizzatti/dash.vim")
    use("LudoPinelli/comment-box.nvim")
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })
    use {
      "ThePrimeagen/refactoring.nvim",
      config = function()
        require("refactoring").setup {
          prompt_func_return_type = { js = true, ts = true, go = true, ruby = true, },
          prompt_func_param_type = { js = true, ts = true, go = true, ruby = true, },
        }
        require("telescope").load_extension "refactoring"
      end,
    }

    use("vim-test/vim-test") -- test running tool for many languages
    use("AndrewRadev/splitjoin.vim") -- Switch between single-line and multiline forms of code: gS to split a one-liner into multiple lines. gJ (with the cursor on the first line of a block) to join a block into a single-line.
    use("AndrewRadev/switch.vim") -- switch segments of text with predefined replacements. default mapping `gs` to trigger the command
    use("kg8m/vim-simple-align")
    -- use("buoto/gotests-vim") -- generate go table driven tests easily
    -- }}}
  end,
  config = {
    max_jobs = 24,
    git = {
      subcommands = {
        update = "pull --ff-only --progress --rebase=true",
      },
    },
  },
})
