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
        use 'wbthomason/packer.nvim'
        use 'nvim-lua/popup.nvim'
        use 'nvim-lua/plenary.nvim'

        -- ============ Appearance ============ -- {{{
        use {
            'goolord/alpha-nvim',
            config = [[require('plugins.config.alpha-nvim')]]
        }
        use {
            "nvim-lualine/lualine.nvim",
            -- config = [[require('plugins.config.lualine')]],
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
        }
        use 'norcalli/nvim-colorizer.lua'
        use 'karb94/neoscroll.nvim' -- smooth scroll
        use 'lukas-reineke/indent-blankline.nvim'
        -- Themes
        use 'sainnhe/everforest'
        use 'folke/tokyonight.nvim'
        use 'EdenEast/nightfox.nvim'
        -- }}}

        -- ============ Core ============ -- {{{
        use 'folke/which-key.nvim'
        use 'kyazdani42/nvim-tree.lua'
        use 'rcarriga/nvim-notify'
        use 'tversteeg/registers.nvim' -- Preview the contents of the registers
        use 'yianwillis/vimcdoc'

        -- Neovim motions on speed! An EasyMotion-like plugin allowing you to jump anywhere in a document
        use {
          'phaazon/hop.nvim',
          config = function () require('hop').setup() end
        }
        use {
          'windwp/nvim-autopairs',
          config = function () require('nvim-autopairs').setup() end
        }
        use 'ethanholz/nvim-lastplace' -- Intelligently reopen files at your last edit position in Vim
        -- use 'dyng/ctrlsf.vim' -- A powered code search and view tool
        use 'windwp/nvim-spectre' -- Find the enemy and replace them with dark power
        use 'rhysd/clever-f.vim' -- Extended f, F, t and T key mappings
        use 'xtal8/traces.vim' -- Range, pattern and substitute preview tool
        use 'akinsho/toggleterm.nvim' -- A neovim lua plugin to help easily manage multiple terminal windows
        use 'voldikss/vim-translator' -- Asynchronous translating plugin
        use 'famiu/bufdelete.nvim' -- Delete Neovim buffers without losing window layout
        use 'nyngwang/NeoZoom.lua'
        use{'anuvyklack/pretty-fold.nvim',
           config = function()
              require('pretty-fold').setup{}
              require('pretty-fold.preview').setup{
                key = 'h',
              }
           end
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

        -- Tim Pope
        use 'tpope/vim-unimpaired' -- pairs of handy bracket mappings, like ]n jumpt to SCM conflict
        use 'tpope/vim-sleuth' -- automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
        use 'tpope/vim-abolish' -- switch case using crc, crs, crm, etc.
        use 'tpope/vim-rails'
        use 'tpope/vim-dadbod'
        use 'tpope/vim-fugitive'
        use {
          'tpope/vim-surround',
          'wellle/targets.vim' -- provides additional powerfull text objects!!
        }

        -- Junegunn Choi
        use { 'junegunn/fzf.vim', requires = {'junegunn/fzf', opt = true} }
        use 'junegunn/vim-fnr' -- Find-N-Replace in Vim with live preview
        use 'junegunn/gv.vim'
        -- CONFLICT with hlslens plugin, so disable it 👇
        -- use 'junegunn/vim-slash' -- automatically clearing Vim's search highlighting whenever the cursor moves or insert mode is entered

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

        -- ============ Programming ============ -- {{{
        -- Treesitter
        use({
          { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
          'nvim-treesitter/nvim-treesitter-textobjects',
          'nvim-treesitter/nvim-treesitter-refactor',
          'nvim-treesitter/playground',
          'lewis6991/spellsitter.nvim',
          'SmiteshP/nvim-gps',
        })

        -- LSP
        use({
          'neovim/nvim-lspconfig',
          'williamboman/nvim-lsp-installer',
        })

        -- Completion
        use({
          'hrsh7th/nvim-cmp',
          requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-vsnip',
            'f3fora/cmp-spell',
            'onsails/lspkind-nvim',
            'ray-x/cmp-treesitter',
            -- snippets
            'rafamadriz/friendly-snippets',
            'quoyi/rails-vscode',
          },
        })
        -- vsnip
        use {
          'hrsh7th/vim-vsnip',
          config = function()
            vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets/'
          end
        }
        use 'hrsh7th/vim-vsnip-integ'

        -- LSP Powerfull Plugins
        use 'stevearc/aerial.nvim'
        use 'rmagatti/goto-preview'
        use 'ray-x/lsp_signature.nvim'
        use {
          "folke/trouble.nvim",
          config = function() require("trouble").setup {} end
        }

        -- Enhancement Plugins
        use 'github/copilot.vim'
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

        use 'vim-test/vim-test' -- test running tool for many languages
        use 'AndrewRadev/splitjoin.vim' -- Switch between single-line and multiline forms of code: gS to split a one-liner into multiple lines. gJ (with the cursor on the first line of a block) to join a block into a single-line.
        use 'AndrewRadev/switch.vim' -- switch segments of text with predefined replacements. default mapping `gs` to trigger the command
        use 'kristijanhusak/vim-dadbod-ui'
        use 'kristijanhusak/vim-dadbod-completion'
        use 'alvan/vim-closetag'
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
