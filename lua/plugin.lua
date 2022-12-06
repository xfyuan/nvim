local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer = require("packer")
local use = packer.use

-- using { } for using different branch , loading plugin with certain commands etc
return packer.startup({
    function()
        use 'lewis6991/impatient.nvim'
        use 'wbthomason/packer.nvim'
        use 'nvim-lua/popup.nvim'
        use 'nvim-lua/plenary.nvim'
        use 'kyazdani42/nvim-web-devicons'

        -- ============ Appearance ============ -- {{{
        use {
            'goolord/alpha-nvim',
            config = [[require('plugins.config.alpha-nvim')]]
        }
        use {
            "nvim-lualine/lualine.nvim",
            config = [[require('plugins.config.lualine')]],
        }
        use 'norcalli/nvim-colorizer.lua'
        use 'lukas-reineke/indent-blankline.nvim'
        use {
          'karb94/neoscroll.nvim',
          config = function()
            require('neoscroll').setup({
              mappings = {'<C-d>', '<C-b>', '<C-f>', '<C-e>', 'zt', 'zz', 'zb'}
            })
          end
        }
        -- Themes
        use 'xfyuan/nightforest.nvim'
        use 'sainnhe/everforest'
        use 'folke/tokyonight.nvim'
        use 'EdenEast/nightfox.nvim'
        use 'Shatur/neovim-ayu'
        -- }}}

        -- ============ Core ============ -- {{{
        use 'folke/which-key.nvim'
        use 'kyazdani42/nvim-tree.lua'
        use 'rcarriga/nvim-notify'
        use 'yianwillis/vimcdoc'

        use {
          'rmagatti/auto-session',
          requires = { 'rmagatti/session-lens', },
          config = function()
            require('session-lens').setup({})
            require('auto-session').setup {
              auto_session_root_dir = vim.fn.stdpath('config').."/sessions/",
              auto_session_enabled = false,
              pre_save_cmds = {"NvimTreeClose"},
              post_restore_cmds = {"NvimTreeOpen"},
            }
          end
        }
        -- Neovim motions on speed! An EasyMotion-like plugin allowing you to jump anywhere in a document
        use {
          'phaazon/hop.nvim',
          config = function () require('hop').setup() end
        }
        use 'ethanholz/nvim-lastplace' -- Intelligently reopen files at your last edit position in Vim
        -- use 'dyng/ctrlsf.vim' -- A powered code search and view tool
        use 'windwp/nvim-spectre' -- Find the enemy and replace them with dark power
        use 'rhysd/clever-f.vim' -- Extended f, F, t and T key mappings
        use 'xtal8/traces.vim' -- Range, pattern and substitute preview tool
        use 'akinsho/toggleterm.nvim' -- A neovim lua plugin to help easily manage multiple terminal windows
        use 'voldikss/vim-translator' -- Asynchronous translating plugin
        use 'famiu/bufdelete.nvim' -- Delete Neovim buffers without losing window layout
        use 'sindrets/diffview.nvim'
        use 'nyngwang/NeoZoom.lua'
        use {
          'https://gitlab.com/yorickpeterse/nvim-window.git',
          config = function()
            vim.cmd [[hi BlackOnLightYellow guifg=#000000 guibg=#f2de91]];
            require('nvim-window').setup({
              chars = {"a", "s", "f", "g", "h", "j", "k", "l"},
              normal_hl = 'BlackOnLightYellow',
              hint_hl = 'Bold',
              border = 'none',
            })
          end
        }
        use({
          "kevinhwang91/nvim-ufo",
          requires = "kevinhwang91/promise-async",
          config = [[require('plugins.config.ufo')]]
        })
        use {
          "ruifm/gitlinker.nvim",
          config = function() require("gitlinker").setup() end,
        }
        use {
          "folke/todo-comments.nvim",
          config = function() require("todo-comments").setup() end
        }
        use {
          'nmac427/guess-indent.nvim',
          config = function() require('guess-indent').setup {} end,
        }
        use {
          'kevinhwang91/nvim-hlslens', -- helps you better glance at matched information, seamlessly jump between matched instances.
          branch = 'main',
          keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}},
          config = [[require('plugins.config.hlslens')]]
        }
        use { "kevinhwang91/nvim-bqf", ft = "qf" } -- Better quickfix window in Neovim

        -- Fuzzy Finder
        use({
          'nvim-telescope/telescope.nvim',
          requires = {
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
            {'nvim-telescope/telescope-symbols.nvim'},
            {'nvim-telescope/telescope-project.nvim'},
            {'nvim-telescope/telescope-packer.nvim'},
            {'nvim-telescope/telescope-dap.nvim'},
            {'crispgm/telescope-heading.nvim'},
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
        use 'mg979/vim-visual-multi'
        use {
          "iamcco/markdown-preview.nvim",
          run = "cd app && yarn install",
          ft = "markdown",
        }

        -- Text Objects
        use 'kana/vim-textobj-user'               -- Create your own text objects
        use 'kana/vim-textobj-line'               -- al | il
        use 'kana/vim-textobj-syntax'             -- ay | iy
        use 'kana/vim-textobj-indent'             -- ai | ii
        use 'kana/vim-textobj-lastpat'            -- a/ | i/
        use 'nelstrom/vim-textobj-rubyblock'      -- ar | ir
        use 'osyo-manga/vim-textobj-multiblock'   -- ab | ib
        use 'idbrii/textobj-word-column.vim'      -- ac | ic
        use 'Julian/vim-textobj-variable-segment' -- av | iv
        use 'bootleq/vim-textobj-rubysymbol'      -- a: | i:
        -- }}}

        -- ============ Legend ============ -- {{{
        -- Tim Pope ⭐
        use 'tpope/vim-fugitive'
        use 'tpope/vim-unimpaired' -- pairs of handy bracket mappings, like ]n jumpt to SCM conflict
        use 'tpope/vim-sleuth' -- automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
        use 'tpope/vim-abolish' -- switch case using crc, crs, crm, etc.
        use 'tpope/vim-rails'
        use 'tpope/vim-dadbod'
        use {
          'tpope/vim-surround',
          'wellle/targets.vim' -- provides additional powerfull text objects!!
        }

        -- Junegunn Choi ⭐
        use { 'junegunn/fzf.vim', requires = {'junegunn/fzf', opt = true} }
        use 'junegunn/vim-fnr' -- Find-N-Replace in Vim with live preview
        use 'junegunn/gv.vim'
        -- CONFLICT with hlslens plugin, so disable it 👇
        -- use 'junegunn/vim-slash' -- automatically clearing Vim's search highlighting whenever the cursor moves or insert mode is entered
        -- }}}

        -- ============ Programming ============ -- {{{
        -- Treesitter
        use {
          'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate',
          requires = {
            {'nvim-treesitter/nvim-treesitter-textobjects'},
            {'nvim-treesitter/nvim-treesitter-refactor'},
            {'nvim-treesitter/playground'},
            {'RRethy/nvim-treesitter-textsubjects'},
            {'JoosepAlviste/nvim-ts-context-commentstring'},
            {'lewis6991/spellsitter.nvim'},
            {'SmiteshP/nvim-gps'},
            {
              'romgrk/nvim-treesitter-context',
              config = function() require('treesitter-context').setup() end
            },
            {
              'windwp/nvim-autopairs',
              config = function () require('nvim-autopairs').setup() end
            },
            {
              'windwp/nvim-ts-autotag',
              config = function() require('nvim-ts-autotag').setup() end
            },
          }
        }

        -- LSP
        use({
          'neovim/nvim-lspconfig',
          'williamboman/nvim-lsp-installer',
        })

        -- Debugger
        use {
            "rcarriga/nvim-dap-ui",
            requires = {
                "mfussenegger/nvim-dap",
                "theHamsta/nvim-dap-virtual-text",
                "leoluz/nvim-dap-go",
            },
            config = function ()
              vim.fn.sign_define('DapBreakpoint', {text='⛔', texthl='', linehl='', numhl=''})
              vim.fn.sign_define('DapStopped', {text='👉', texthl='', linehl='', numhl=''})
              -- vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
              -- vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='', linehl='', numhl=''})
              -- vim.fn.sign_define('DapLogPoint', {text='ﱴ', texthl='', linehl='', numhl=''})
              -- vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='', numhl=''})
              -- vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='', linehl='', numhl=''})
              require('dapui').setup({
                mappings = {
                  expand = { "o", "<2-LeftMouse>" },
                  open = "<CR>",
                  remove = "d",
                  edit = "e",
                  repl = "r",
                  toggle = "t",
                },
              })
              require("nvim-dap-virtual-text").setup()
              require('dap-go').setup()
              require('dap.ext.vscode').load_launchjs()
            end
        }
        -- Completion
        use({
          'hrsh7th/nvim-cmp',
          requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'f3fora/cmp-spell',
            'onsails/lspkind-nvim',
            'ray-x/cmp-treesitter',
            'lukas-reineke/cmp-under-comparator',
          },
          config = [[require('plugins.config.cmp')]]
        })
        -- snippets
        use { "L3MON4D3/LuaSnip",
          requires = {
            'rafamadriz/friendly-snippets',
            'quoyi/rails-vscode',
            'benfowler/telescope-luasnip.nvim',
          }
        }

        -- LSP Powerfull Plugins
        use 'stevearc/aerial.nvim'
        use 'kosayoda/nvim-lightbulb'
        use 'haringsrob/nvim_context_vt'
        use 'jose-elias-alvarez/nvim-lsp-ts-utils'
        use {
          "j-hui/fidget.nvim",
          config = function() require("fidget").setup {} end,
        }
        use 'ray-x/lsp_signature.nvim'
        use {
          'ray-x/go.nvim',
          config = function() require('go').setup() end
        }
        use {
          "folke/trouble.nvim",
          config = function() require("trouble").setup {} end
        }

        -- Enhancement Plugins
        use 'zackhsi/fzf-tags'
        use 'lewis6991/gitsigns.nvim'
        use 'rizzatti/dash.vim'
        -- use 'tomtom/tcomment_vim'
        use {
          'numToStr/Comment.nvim',
          config = function() require('Comment').setup() end
        }
        use {
          'mhartington/formatter.nvim',
          config = [[require('plugins.config.formatter')]]
        }
        use {
          'RRethy/nvim-treesitter-endwise',
          config = function()
            require('nvim-treesitter.configs').setup {
                endwise = {
                  enable = true,
                },
            }
          end
        }

        use 'vim-test/vim-test' -- test running tool for many languages
        use 'buoto/gotests-vim' -- generate go table driven tests easily
        use 'AndrewRadev/splitjoin.vim' -- Switch between single-line and multiline forms of code: gS to split a one-liner into multiple lines. gJ (with the cursor on the first line of a block) to join a block into a single-line.
        use 'AndrewRadev/switch.vim' -- switch segments of text with predefined replacements. default mapping `gs` to trigger the command
        use 'kristijanhusak/vim-dadbod-ui'
        use 'kristijanhusak/vim-dadbod-completion'
        use 'kg8m/vim-simple-align'
        -- use 'alvan/vim-closetag'
        -- use 'kchmck/vim-coffee-script'
        -- }}}
    end,
    config = {
      max_jobs = 36,
      git = {
        subcommands = {
          update = 'pull --ff-only --progress --rebase=true',
        }
      },
    },
})
