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
return packer.startup(
    function()
        use 'wbthomason/packer.nvim'
        use 'nvim-lua/popup.nvim'
        use 'nvim-lua/plenary.nvim'

        -- ============ Appearance ============ -- {{{
        use {
            "nvim-lualine/lualine.nvim",
            -- config = [[require('plugins.lualine')]],
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
        }
        -- use 'akinsho/nvim-bufferline.lua'
        use 'norcalli/nvim-colorizer.lua'
        use 'karb94/neoscroll.nvim' -- smooth scroll
        use 'lukas-reineke/indent-blankline.nvim'
        -- Themes
        use 'sainnhe/everforest'
        use 'shaunsingh/nord.nvim'
        use 'folke/tokyonight.nvim'
        -- }}}

        -- ============ Core ============ -- {{{
        use 'folke/which-key.nvim'
        use 'kyazdani42/nvim-tree.lua'
        use 'phaazon/hop.nvim' -- Neovim motions on speed! An EasyMotion-like plugin allowing you to jump anywhere in a document
        use 'tversteeg/registers.nvim' -- Preview the contents of the registers
        use 'windwp/nvim-autopairs'
        use 'ethanholz/nvim-lastplace' -- Intelligently reopen files at your last edit position in Vim
        -- use 'dyng/ctrlsf.vim' -- A powered code search and view tool
        use 'windwp/nvim-spectre' -- Find the enemy and replace them with dark power
        use 'rhysd/clever-f.vim' -- Extended f, F, t and T key mappings
        use 'xtal8/traces.vim' -- Range, pattern and substitute preview tool
        use 'akinsho/toggleterm.nvim' -- A neovim lua plugin to help easily manage multiple terminal windows
        use 'voldikss/vim-translator' -- Asynchronous translating plugin
        use 'famiu/bufdelete.nvim' -- Delete Neovim buffers without losing window layout
        use { "beauwilliams/focus.nvim", config = function() require("focus").setup({signcolumn = false}) end }
        use 'rcarriga/nvim-notify'

        -- Fuzzy Finder
        use({
          'nvim-telescope/telescope.nvim',
          requires = {
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
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
        use 'junegunn/vim-fnr' -- Find-N-Replace in Vim with live preview
        use 'junegunn/vim-slash' -- automatically clearing Vim's search highlighting whenever the cursor moves or insert mode is entered
        use 'junegunn/gv.vim'
        -- use 'junegunn/fzf.vim'
        use { 'junegunn/fzf.vim', requires = {'junegunn/fzf', opt = true} }

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
          -- generic LSP for diagnostic, formatting, etc
          'jose-elias-alvarez/null-ls.nvim',
        })

        -- Completion
        use({
          'hrsh7th/nvim-cmp',
          requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-vsnip',
            'f3fora/cmp-spell',
            'onsails/lspkind-nvim',
            'ray-x/cmp-treesitter',
            -- vsnip
            'hrsh7th/vim-vsnip',
            'hrsh7th/vim-vsnip-integ',
            -- snippets
            'rafamadriz/friendly-snippets',
            'quoyi/rails-vscode',
          },
        })

        -- LSP Powerfull Plugins
        use 'stevearc/aerial.nvim'
        use 'zackhsi/fzf-tags'
        use 'rmagatti/goto-preview'
        -- use 'ray-x/lsp_signature.nvim'
        -- use 'folke/lsp-trouble.nvim'
        -- use 'simrat39/symbols-outline.nvim'

        use 'github/copilot.vim'

        use 'lewis6991/gitsigns.nvim'
        use 'rizzatti/dash.vim'
        -- use 'terrortylor/nvim-comment'
        use 'tomtom/tcomment_vim'
        -- use 'sbdchd/neoformat'
        use 'mhartington/formatter.nvim'

        use 'vim-test/vim-test' -- test running tool for many languages
        use 'pechorin/any-jump.vim' -- code inspection plugin for finding defitinitions and references/usages
        use 'AndrewRadev/splitjoin.vim' -- Switch between single-line and multiline forms of code: gS to split a one-liner into multiple lines. gJ (with the cursor on the first line of a block) to join a block into a single-line.
        use 'AndrewRadev/switch.vim' -- switch segments of text with predefined replacements. default mapping `gs` to trigger the command
        use 'kristijanhusak/vim-dadbod-ui'
        use 'kristijanhusak/vim-dadbod-completion'
        use 'alvan/vim-closetag'
        use 'kchmck/vim-coffee-script'
        -- }}}

        -- ============ Misc ============ -- {{{
        use 'glepnir/dashboard-nvim'
        -- use 'tweekmonster/startuptime.vim'
        -- use 'kdav5758/TrueZen.nvim'
        -- }}}
    end,
    {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
        }
    }
)
