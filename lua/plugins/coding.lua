return {
  --  +------------------------------------------------------------------------------+
  --  |                              Basic enhencement                               |
  --  +------------------------------------------------------------------------------+
  -- { "rizzatti/dash.vim", event = "VeryLazy" },

  -- Switch between single-line and multiline forms of code: gS to split a one-liner into multiple lines. gJ (with the cursor on the first line of a block) to join a block into a single-line.
  -- { "AndrewRadev/splitjoin.vim", event = "VeryLazy" },
  -- Splitting/joining blocks of code
  {
    "Wansmer/treesj",
    keys = {
      { "gT", "<cmd>TSJToggle<cr>", desc = "Split/Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  -- switch segments of text with predefined replacements. default mapping `gs` to trigger the command
  {
    "AndrewRadev/switch.vim",
    keys = {
      { "gt", "<cmd>Switch<cr>", desc = "Switch segments of text" },
    },
  },
  -- surround, visual mode key mapping `S` to surround selected text
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup()
    end
  },
  -- auto pair parentheses, quotes, and similar contexts
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
      mappings = {
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
      },
    },
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  -- better text-objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      local Mini = require("util.mini")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          i = Mini.ai_indent, -- indent
          g = Mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      local Mini = require("util.mini")
      require("mini.ai").setup(opts)
      require("util").on_load("which-key.nvim", function()
        vim.schedule(function()
          Mini.ai_whichkey(opts)
        end)
      end)
    end,
  },
  --  +------------------------------------------------------------------------------+
  --  |                                   Comments                                   |
  --  +------------------------------------------------------------------------------+
  -- key mapping use `gcB`
  {
    "LudoPinelli/comment-box.nvim",
    event = "VeryLazy",
    opts = {
      doc_width = 100,
      box_width = 80,
    },
    keys = {
      { "gcB", "<cmd>CBccbox10<CR>", desc = "Comment box ascii" }
    },
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    opts = {
      ignore = "^$",
    },
  },
  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    opts = {
      keywords = {
        XY = { icon = " ", color = "warning" },
      },
    },
    config = true,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment", },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment", },
      { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
    },
  },
  --  +------------------------------------------------------------------------------+
  --  |                                 Programming                                  |
  --  +------------------------------------------------------------------------------+
  -- A code outline window for skimming and quick navigation
  {
    "stevearc/aerial.nvim",
    event = "User AstroFile",
    keys = {
      { "<leader>o", "<cmd>AerialToggle<cr>", desc = "Toggle code outline window" },
    },
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = { min_width = 28 },
      manage_folds = true,
      link_folds_to_tree = true,
      link_tree_to_folds = true,
      show_guides = true,
      filter_kind = false,
      autojump = true,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
    },
  },
  -- A small Neovim plugin for previewing definitions using floating windows. default key mapping is `gp*`
  -- { "rmagatti/goto-preview",
  --   event = { "BufReadPost", "BufNewFile" },
  --   opts = {
  --     default_mappings = true,
  --   },
  -- },
  -- Better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>xS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
  -- references
  {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    opts = {
      delay = 200,
      large_file_cutoff = 5000, -- number of lines
      filetypes_denylist = {
        "DressingSelect",
        "neo-tree",
        "TelescopePrompt",
        "Trouble",
        "aerial",
        "alpha",
        "dashboard",
        "fugitive",
        "help",
        "toggleterm",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
          pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
        end,
      })
    end,
  },
  -- refactoring library based off the Refactoring book by Martin Fowler
  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   opts = {},
  --   config = function(_, opts)
  --     require("refactoring").setup(opts)
  --     require("telescope").load_extension "refactoring"
  --   end,
  --   keys = function ()
  --     vim.api.nvim_set_keymap(
  --       "v",
  --       "<leader>rr",
  --       "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  --       { noremap = true, silent = true }
  --     )
  --   end
  -- },
  -- navigate between files that are related using regexp pattern
  {
    "otavioschwanck/telescope-alternate" ,
    config = function()
      require('telescope-alternate').setup({
        presets = { 'rails', 'rspec', },
        mappings = {
          -- jihulab rails
          { 'jh/app/models/(.*).rb', {
            { 'jh/app/controllers/**/*[1:pluralize]_controller.rb', 'JH Controller' },
            { 'jh/app/views/[1:pluralize]/*.html.haml', 'JH View' },
            { 'jh/app/helpers/[1]_helper.rb', 'JH Helper' },
          } },
          { 'jh/app/controllers(.*)/(.*)_controller.rb', {
            { 'jh/app/models/**/*[2:singularize].rb', 'JH Model' },
            { 'jh/app/views/[1][2]/*.html.haml', 'JH View' },
            { 'jh/app/helpers/**/*[2]_helper.rb', 'JH Helper' },
          } },
          -- jihulab rspec
          { 'jh/app/(.*).rb', { { 'jh/spec/[1]_spec.rb', 'JH Test' } } },
          { 'jh/spec/(.*)_spec.rb', { { 'jh/app/[1].rb', 'JH Original', true } } },
          { 'jh/app/controllers/(.*)_controller.rb', { { 'jh/spec/requests/[1]_spec.rb', 'JH Request Test' } } },
          { 'jh/spec/requests/(.*)_spec.rb', { { 'jh/app/controllers/[1]_controller.rb', 'JH Original Controller', true } } },
        },
      })
      require('telescope').load_extension('telescope-alternate')
    end,
  },
  {
    "rgroli/other.nvim" ,
    event = "VeryLazy",
    keys = {
      { "<leader>lo", "<cmd>Other<cr>", desc = "Open other file", ft = "ruby" },
    },
    config = function()
      require("other-nvim").setup({
        mappings = {
          "rails",
          "golang",
        },
        style = {
          border = "rounded",
          width = 0.6,
        },
      })
    end,
  },
  -- Treesitter based structural search and replace
  -- Press <leader><cr> to replace all matches in current buffer,
  -- or <cr> to choose which match to replace.
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>rs",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },
  --  +------------------------------------------------------------------------------+
  --  |                                   Testing                                    |
  --  +------------------------------------------------------------------------------+
  -- test running tool for many languages
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>tc", "<cmd>TestClass<cr>", desc = "Class" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "File" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Last" },
      { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Nearest" },
      { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Suite" },
      { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Visit" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim" -- 'basic' or 'neovim'
      vim.g["test#neovim#term_position"] = "belowright"
      vim.g["test#neovim#preserve_screen"] = 1
      vim.g["test#ruby#rspec#executable"] = "bundle exec rspec"
      vim.g["test#go#gotest#executable"] = "go test -v"
    end,
  },
--  +------------------------------------------------------------------------------+
--  |                                    Debug                                     |
--  +------------------------------------------------------------------------------+
  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     { "rcarriga/nvim-dap-ui" },
  --     { "theHamsta/nvim-dap-virtual-text" },
  --     { "nvim-telescope/telescope-dap.nvim" },
  --     { "leoluz/nvim-dap-go" },
  --   },
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
  --     { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
  --     { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle UI", },
  --     { "<leader>dC", function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
  --     { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
  --     { "<leader>db", function() require("dap").step_back() end, desc = "Step Back", },
  --     { "<leader>dc", function() require("dap").continue() end, desc = "Continue", },
  --     { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect", },
  --     { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Evaluate", },
  --     { "<leader>dg", function() require("dap").session() end, desc = "Get Session", },
  --     { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover Variables", },
  --     { "<leader>di", function() require("dap").step_into() end, desc = "Step Into", },
  --     { "<leader>du", function() require("dap").step_out() end, desc = "Step Out", },
  --     { "<leader>do", function() require("dap").step_over() end, desc = "Step Over", },
  --     { "<leader>dp", function() require("dap").pause.toggle() end, desc = "Pause", },
  --     { "<leader>dq", function() require("dap").close() end, desc = "Quit", },
  --     { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
  --     { "<leader>ds", function() require("dap").continue() end, desc = "Start", },
  --     { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
  --     { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate", },
  --   },
  --   config = function()
  --     require("nvim-dap-virtual-text").setup {
  --       commented = true,
  --     }

  --     local dap, dapui = require "dap", require "dapui"
  --     dapui.setup {}

  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated["dapui_config"] = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited["dapui_config"] = function()
  --       dapui.close()
  --     end

  --     require("dap.ext.vscode").load_launchjs()
  --     require("telescope").load_extension "dap"
  --     -- adapters
  --     require("dap-go").setup()
  --   end,
  -- },
}
