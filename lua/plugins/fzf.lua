return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, opts)
      local fzf_lua = require("fzf-lua")
      local config = fzf_lua.config
      local actions = fzf_lua.actions

      -- Quickfix
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
      config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
      config.defaults.keymap.builtin["<c-h>"] = "toggle-help"
      config.defaults.keymap.builtin["<c-p>"] = "toggle-preview"

      -- Trouble
      config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open

      return {
        fzf_colors = true,
        fzf_opts = {
          ['--cycle'] = true,
          ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-history',
        },
        previewers = {
          builtin = {
            ueberzug_scaler = "fit_contain",
            syntax_limit_b = 1024 * 100, -- 100KB
          },
        },
        winopts = {
          width = 0.9,
          height = 0.9,
          row = 0.5,
          col = 0.5,
          preview = {
            horizontal = 'right:45%',
            scrollchars = { "┃", "" },
          },
        },
        defaults = {
          -- VS Code style
          -- formatter = { "path.filename_first", 2 },
        },
        files = {
          multiprocess = true,
          git_icons = false,
          file_icons = false,
          cwd_prompt = false,
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
        oldfiles = {
          include_current_session = true,
        },
        grep = {
          multiprocess = true,
          rg_glob = true,
          rg_glob_fn = function(query, opts)
            local regex, flags = query:match("^(.-)%s%-%-(.*)$")
            return (regex or query), flags
          end,
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
            ["ctrl-t"] = { function ()
              fzf_lua.live_grep({ no_esc=true, search = fzf_lua.get_last_query() .. ' -- -truby'})
            end },
          },
        },
        git = {
          files = {
            multiprocess = true,
          },
          bcommits = {
            actions = {
              ["ctrl-y"]  = { fn = function(selected, _)
                local commit_hash = selected[1]:match("[^ ]+")
                vim.fn.setreg([[+]], commit_hash)
              end, exec_silent = true },
            },
          },
        },
        lsp = {
          async_or_timeout = true,
          symbols = {
            symbol_hl = function(s)
              return "TroubleIcon" .. s
            end,
            symbol_fmt = function(s)
              return s:lower() .. "\t"
            end,
            child_prefix = false,
          },
          code_actions = {
            previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
          },
        },
      }
    end,
    -- config = function(_, opts)
    --   require("fzf-lua").setup(opts)
    -- end,
    keys = {
      { "jj", "<cmd>close<cr>", ft = "fzf", mode = "t", nowait = true },
      { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
      { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
      -- {
      --   "<leader>,",
      --   "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
      --   desc = "Switch Buffer",
      -- },
      { "<leader>fz/", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep (Root Dir)" },
      { "<leader>fzc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      -- find
      { "<leader>fzf", "<cmd>FzfLua files<cr>", desc = "Find Files (Root Dir)" },
      { "<leader>fzb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fzh", "<cmd>FzfLua oldfiles cwd_only=true<cr>", desc = "Recent" },
      { "<leader>fzC", "<cmd>FzfLua colorschemes<cr>", desc = "Colorscheme with Preview" },
      -- git
      { "<leader>fzg", "<cmd>FzfLua git_status<CR>", desc = "Status" },
      -- { "<leader>gl", "<cmd>FzfLua git_bcommits<CR>", desc = "Commits" },
      -- { "<leader>gl", "<cmd>FzfLua git_bcommits<CR>", mode = {"n", "v"}, desc = "Commits" },
      -- { "<leader>gL", "<cmd>FzfLua git_commits<CR>", desc = "Commits (Project)" },
      -- search
      -- { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      -- { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      -- { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      -- { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      -- { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      -- { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      -- { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      -- { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      -- { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
      -- { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      -- { "<leader>sL", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
      -- { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>fzm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>fzr", "<cmd>FzfLua registers<cr>", desc = "Registers" },
      -- { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      -- { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
      { "<leader>fzw", "<cmd>FzfLua grep_cword<cr>", desc = "Word (Root Dir)" },
      { "<leader>fzw", "<cmd>FzfLua grep_visual<cr>", mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>fzt", "<cmd>FzfLua btags<cr>", desc = "Buffer Tags" },
      { "<leader>fz.", "<cmd>FzfLua tags_grep_cword<cr>", desc = "Tag Word (Project)" },
      {
        "<leader>fzs",
        function()
          require("fzf-lua").lsp_document_symbols({
            regex_filter = symbols_filter,
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>fzS",
        function()
          require("fzf-lua").lsp_live_workspace_symbols({
            regex_filter = symbols_filter,
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    cmd = { "AdvancedGitSearch" },
    keys = {
      { "<leader>fzL", "<cmd>AdvancedGitSearch search_log_content<CR>", desc = "Search in repo git log content" },
      { "<leader>fzl", "<cmd>AdvancedGitSearch search_log_content_file<CR>", desc = "Search in file git log content" },
      { "<leader>fzl", ":'<,'>AdvancedGitSearch diff_commit_line<CR>", mode = {"v"}, desc = "Diff current file with selected line history" },
    },
    config = function()
      require("advanced_git_search.fzf").setup{}
    end,
  },

  -- {
  --   "folke/todo-comments.nvim",
  --   optional = true,
  --   keys = {
  --     { "<leader>st", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
  --     { "<leader>sT", function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
  --   },
  -- },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function()
  --     local Keys = require("plugins.lsp.keymaps").get()
  --     vim.list_extend(Keys, {
  --       { "gd", "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Definition", has = "definition" },
  --       { "gr", "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>", desc = "References", nowait = true },
  --       { "gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Implementation" },
  --       { "gy", "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto T[y]pe Definition" },
  --     })
  --   end,
  -- },
}
