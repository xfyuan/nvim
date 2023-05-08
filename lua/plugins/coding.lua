return {
  --  +------------------------------------------------------------------------------+
  --  |                              Basic enhencement                               |
  --  +------------------------------------------------------------------------------+
  { "rizzatti/dash.vim", event = "VeryLazy" },

  -- Switch between single-line and multiline forms of code: gS to split a one-liner into multiple lines. gJ (with the cursor on the first line of a block) to join a block into a single-line.
  { "AndrewRadev/splitjoin.vim", event = "VeryLazy" },

  -- switch segments of text with predefined replacements. default mapping `gs` to trigger the command
  {
    "AndrewRadev/switch.vim",
    keys = {
      { "gt", "<cmd>Switch<cr>", desc = "Switch" },
    },
  },
  -- tabbing out from parentheses, quotes, and similar contexts
  {
    "abecodes/tabout.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
    config = true,
  },
  -- surround
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup()
    end
  },
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  -- better text-objects
  {
    "echasnovski/mini.ai",
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      local ai = require("mini.ai")
      ai.setup(opts)
    end,
  },
  --  +------------------------------------------------------------------------------+
  --  |                                   Comments                                   |
  --  +------------------------------------------------------------------------------+
  { "LudoPinelli/comment-box.nvim", event = "VeryLazy" },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment", },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment", },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
    },
  },
  --  +------------------------------------------------------------------------------+
  --  |                                 Programming                                  |
  --  +------------------------------------------------------------------------------+
  -- A code outline window for skimming and quick navigation
  {
    "stevearc/aerial.nvim",
    config = true,
  },
  -- references
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
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
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference", },
    },
  },
  -- refactoring library based off the Refactoring book by Martin Fowler
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function(_, opts)
      require("refactoring").setup(opts)
      require("telescope").load_extension "refactoring"
    end,
    keys = function ()
      vim.api.nvim_set_keymap(
        "v",
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        { noremap = true, silent = true }
      )
    end
  },
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
  -- a modern user interface to run or debug test cases
  {
    "nvim-neotest/neotest",
    keys = {
      -- { "<leader>tnF", "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", desc = "Debug File" },
      -- { "<leader>tnL", "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>", desc = "Debug Last" },
      -- { "<leader>tnN", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
      { "<leader>tna", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach" },
      { "<leader>tnf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "File" },
      { "<leader>tnl", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "Last" },
      { "<leader>tnn", "<cmd>lua require('neotest').run.run()<cr>", desc = "Nearest" },
      { "<leader>tno", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
      { "<leader>tns", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Summary" },
      { "<leader>tnt", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop" },
    },
    dependencies = {
      "vim-test/vim-test",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "nvim-neotest/neotest-go",
      "olimorris/neotest-rspec",
    },
    config = function()
      local opts = {
        adapters = {
          require("neotest-go"),
          require("neotest-rspec"),
          require("neotest-plenary"),
          require("neotest-vim-test")({
            ignore_file_types = { "vim", "lua" },
          }),
        },
      }
      require("neotest").setup(opts)
    end,
  },
--  +------------------------------------------------------------------------------+
--  |                                    Debug                                     |
--  +------------------------------------------------------------------------------+
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "leoluz/nvim-dap-go" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
      { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
      { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle UI", },
      { "<leader>dC", function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
      { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
      { "<leader>db", function() require("dap").step_back() end, desc = "Step Back", },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue", },
      { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect", },
      { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Evaluate", },
      { "<leader>dg", function() require("dap").session() end, desc = "Get Session", },
      { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover Variables", },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into", },
      { "<leader>du", function() require("dap").step_out() end, desc = "Step Out", },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over", },
      { "<leader>dp", function() require("dap").pause.toggle() end, desc = "Pause", },
      { "<leader>dq", function() require("dap").close() end, desc = "Quit", },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
      { "<leader>ds", function() require("dap").continue() end, desc = "Start", },
      { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
      { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate", },
    },
    config = function()
      require("nvim-dap-virtual-text").setup {
        commented = true,
      }

      local dap, dapui = require "dap", require "dapui"
      dapui.setup {}

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      require("dap.ext.vscode").load_launchjs()
      require("telescope").load_extension "dap"
      -- adapters
      require("dap-go").setup()
    end,
  },
}
