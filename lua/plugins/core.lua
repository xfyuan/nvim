return {
  -- library used by other plugins
  { "nvim-lua/popup.nvim", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },

  -- documention
  { "yianwillis/vimcdoc", event = "BufReadPre" },
  { "milisims/nvim-luaref", event = "BufReadPre" }, -- Add a vim :help reference for lua

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  -- terminal toggle
  -- {
  --   "akinsho/toggleterm.nvim",
  --   lazy = false,
  --   cmd = { "ToggleTerm", "TermExec" },
  --   opts = {
  --     open_mapping = [[<C-\>]],
  --     direction = "horizontal",
  --     size = 16,
  --   },
  --   keys = {
  --     { "<leader>tms", "<cmd>ToggleTermSendVisualSelection<cr>", mode = { 'v' }, desc = "Send selection to terminal" },
  --     { "<leader>tml", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "Send line to terminal" },
  --   },
  -- },

  -- buffer remove
  -- {
  --   "echasnovski/mini.bufremove",
  --   keys = {
  --     { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
  --     { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)", },
  --   },
  -- },

  -- beautiful buffer line bar
  -- {
  --   "akinsho/nvim-bufferline.lua",
  --   event = "VeryLazy",
  --   keys = {
  --     { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle buffer pin" },
  --     { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  --   },
  --   opts = {
  --     options = {
  --       mode = "buffers", -- tabs or buffers
  --       numbers = "buffer_id",
  --       diagnostics = "nvim_lsp",
  --       always_show_bufferline = false,
  --       separator_style = "slant" or "padded_slant",
  --       show_tab_indicators = true,
  --       show_buffer_close_icons = false,
  --       show_close_icon = false,
  --       color_icons = true,
  --       enforce_regular_tabs = false,
  --       custom_filter = function(buf_number, _)
  --         local tab_num = 0
  --         for _ in pairs(vim.api.nvim_list_tabpages()) do
  --           tab_num = tab_num + 1
  --         end

  --         if tab_num > 1 then
  --           if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then
  --             return true
  --           end
  --         else
  --           return true
  --         end
  --       end,
  --       sort_by = function(buffer_a, buffer_b)
  --         local mod_a = ((vim.loop.fs_stat(buffer_a.path) or {}).mtime or {}).sec or 0
  --         local mod_b = ((vim.loop.fs_stat(buffer_b.path) or {}).mtime or {}).sec or 0
  --         return mod_a > mod_b
  --       end,
  --     },
  --   },
  -- },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<C-u>",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      close_if_last_window = true,
      filesystem = {
        bind_to_cwd = false,
        use_libuv_file_watcher = true,
        follow_current_file = { enabled = true},
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ['/'] = 'noop',
          ['z'] = 'noop',
          ['M'] = 'close_all_nodes',
          ["o"] = "open",
          ["e"] = function() vim.api.nvim_exec("Neotree focus filesystem left",true) end,
          ["b"] = function() vim.api.nvim_exec("Neotree focus buffers left",true) end,
          -- ["g"] = function() vim.api.nvim_exec("Neotree focus git_status left",true) end,
          ["Y"] = function(state)
            local node = state.tree:get_node()
            -- relative
            local content = node.path:gsub(state.path, ""):sub(2)
            vim.fn.setreg('"', content)
            vim.fn.setreg('*', content)
          end,
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(_)
            require("neo-tree").close_all()
          end
        },
      }
    },
  },
}
