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
      { "tsakirist/telescope-lazy.nvim" },
      { "crispgm/telescope-heading.nvim" },
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
    },
    keys = {
      -- search
      { "<C-p>", Util.telescope("files"), desc = "Find Files" },
      { "<leader>ff", Util.telescope("files"), desc = "Find Files" },
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
    opts = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.load_extension("fzf")
      telescope.load_extension("lazy")
      telescope.load_extension("heading")
      telescope.load_extension("session-lens")
      telescope.load_extension("aerial")

      return {
        extensions = {
          fzf = {
            case_mode = "smart_case",
            fuzzy = true,
            override_file_sorter = true,
            override_generic_sorter = true,
          },
        },
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          layout_config = {
            prompt_position = "top",
          },
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["jj"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-g>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<c-t>"] = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
              end,
            },
            n = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-c>"] = { "<c-u>", type = "command" }, -- delete inputted text
            },
          },
        },
      }
    end,
  },
}
