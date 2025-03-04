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
