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
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  -- surround
  {
    "echasnovski/mini.surround",
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup(opts)
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
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
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
    opts = { delay = 200 },
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
}
