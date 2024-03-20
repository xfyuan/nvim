local Util = require("util")

return {
  -- Simple session management
  {
    "olimorris/persisted.nvim",
    keys = {
      { "<leader>ss", "<cmd>SessionSave<cr>", desc = "persisted Save session" },
      { "<leader>sl", "<cmd>SessionLoad<cr>", desc = "persisted Load session" },
      { "<leader>sd", "<cmd>SessionDelete<cr>", desc = "persisted Delete session" },
      { "<leader>sf", "<cmd>Telescope persisted<cr>", desc = "persisted Find session" },
    },
    opts = {
        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
        use_git_branch = true,
        autosave = true,
        should_autosave = function()
          if vim.bo.filetype == "alpha" then
            return false
          end
          return true
        end,
    },
  },
  -- telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-symbols.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { 'nvim-telescope/telescope-frecency.nvim', },
      { 'nvim-telescope/telescope-smart-history.nvim', },
      { 'nvim-telescope/telescope-live-grep-args.nvim', },
      { 'fcying/telescope-ctags-outline.nvim' },
      { 'gnfisher/nvim-telescope-ctags-plus' },
      { "aaronhallaert/advanced-git-search.nvim" },
      { "tsakirist/telescope-lazy.nvim" },
      { "jemag/telescope-diff.nvim" },
      { "crispgm/telescope-heading.nvim" },
      {  'kkharji/sqlite.lua'  },
    },
    keys = {
      -- search
      { "<C-p>", Util.telescope("files"), desc = "Find Files" },
      { "<leader>fO", "<cmd>Telescope aerial<cr>", desc = "Find aerial symbol" },
      { "<leader>ff", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
      { "<leader>fo", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File browser on current buffer" },
      { "<leader>fc", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>cs",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local actions_layout = require("telescope.actions.layout")
      local lga_actions = require('telescope-live-grep-args.actions')
      local enter_normal_mode = function()
        local mode = vim.api.nvim_get_mode().mode
        if mode == "i" then
          vim.cmd [[stopinsert]]
          return
        end
      end

      local layout_strategies = require("telescope.pickers.layout_strategies")
      layout_strategies.dynamic = function(self, max_columns, max_lines, layout_config)
        if vim.o.columns > 120 then
          return layout_strategies.flex(self, max_columns, max_lines, layout_config)
        else
          return layout_strategies.vertical(self, max_columns, max_lines, layout_config)
        end
      end

      local opts = {
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "dynamic",
          layout_config = {
            prompt_position = "top",
          },
          dynamic_preview_title = true,
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { 'truncate' },
          file_ignore_patterns = {"node_modules", "vendor/bundle", "%.jpg", "%.png"},
          history = {
            path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
            limit = 500,
          },
          mappings = {
            i = {
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["jj"] = actions.close,
              ["jk"] = enter_normal_mode,
              ["|"] = actions_layout.toggle_preview,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-g>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<c-h>"] = actions.which_key,
              ["<c-t>"] = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
              end,
            },
            n = {
              ["q"] = actions.close,
            }
          },
        },
        extensions = {
          fzf = {
            case_mode = "smart_case",
            fuzzy = true,
            override_file_sorter = true,
            override_generic_sorter = true,
          },
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          },
          frecency = {
            auto_validate = false,
            show_scores = true,
            default_workspace = 'CWD',
            show_unindexed = false,
            ignore_patterns = { '*.git/*', '*node_modules/*', '*vendor/*' },
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-e>"] = lga_actions.quote_prompt(),
                -- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),
                ["<C-h>"] = lga_actions.quote_prompt({ postfix = " -truby app lib ee jh -g '!spec/'" }),
              },
            },
          },
          advanced_git_search = {
            diff_plugin = "fugitive",
            show_builtin_git_pickers = false,
            git_flags = {},
            git_diff_flags = {},
          }
        },
        aerial = {
          show_nesting = {
            ["_"] = false, -- This key will be the default
            lua = true, -- You can set the option for specific filetypes
          },
        },
      }
      telescope.setup(opts)

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("frecency")
      telescope.load_extension("smart_history")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("advanced_git_search")
      telescope.load_extension("ctags_outline")
      telescope.load_extension("ctags_plus")
      telescope.load_extension("lazy")
      telescope.load_extension("heading")
      telescope.load_extension("persisted")
      telescope.load_extension("aerial")
      telescope.load_extension("diff")

      vim.api.nvim_create_user_command(
        "DiffCommitLine",
        "lua require('telescope').extensions.advanced_git_search.diff_commit_line()",
        { range = true }
      )
      vim.api.nvim_set_keymap( "v", "<leader>gl", ":DiffCommitLine<CR>", { noremap = true })

      vim.api.nvim_set_keymap( "n", "g]", ":lua require('telescope').extensions.ctags_plus.jump_to_tag()<CR>", { noremap = true })
      vim.api.nvim_set_keymap( "n", "<leader>o", ":Telescope ctags_outline outline<CR>", { noremap = true })
    end,
  },
}
