local Util = require("util")

return {
  -- telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-symbols.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { 'nvim-telescope/telescope-frecency.nvim', },
      { 'nvim-telescope/telescope-smart-history.nvim', },
      { 'nvim-telescope/telescope-live-grep-args.nvim', },
      { "aaronhallaert/advanced-git-search.nvim" },
      { "tsakirist/telescope-lazy.nvim" },
      { "crispgm/telescope-heading.nvim" },
      {  'kkharji/sqlite.lua'  },
      {
        "rmagatti/auto-session", -- Auto Session takes advantage of Neovim's existing session management capabilities to provide seamless automatic session management
        dependencies = { "rmagatti/session-lens" },
        config = function()
          require("session-lens").setup({})
          require("auto-session").setup({
            auto_session_root_dir = vim.fn.stdpath("config") .. "/sessions/",
            auto_session_enabled = false,
            auto_session_use_git_branch = true,
          })
        end,
      },
    },
    keys = {
      -- search
      { "<C-p>", Util.telescope("files"), desc = "Find Files" },
      { "<leader>ff", "<cmd>Telescope file_browser<cr>", desc = "Browser" },
      { "<leader>fo", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "Browser on current buffer" },
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

      local opts = {
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "flex",
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
          },
          mappings = {
            i = {
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["jj"] = actions.close,
              ["jk"] = enter_normal_mode,
              ["?"] = actions_layout.toggle_preview,
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
            default_workspace = 'CWD',
            show_unindexed = false,
            ignore_patterns = { '*.git/*', '*node_modules/*', '*vendor/*' },
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-e>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),
                ["<C-h>"] = lga_actions.quote_prompt({ postfix = " -truby lib app ee jh -g '!spec/'" }),
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
      }
      telescope.setup(opts)

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("frecency")
      telescope.load_extension("smart_history")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("advanced_git_search")
      telescope.load_extension("lazy")
      telescope.load_extension("heading")
      telescope.load_extension("session-lens")
      telescope.load_extension("aerial")

      vim.api.nvim_create_user_command(
        "DiffCommitLine",
        "lua require('telescope').extensions.advanced_git_search.diff_commit_line()",
        { range = true }
      )
      vim.api.nvim_set_keymap( "v", "<leader>gl", ":DiffCommitLine<CR>", { noremap = true })
    end,
  },
}
