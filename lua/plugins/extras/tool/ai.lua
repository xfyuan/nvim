return {
  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    keys = {},
    opts = {
      -- suggestion = { enabled = false },
      -- panel = { enabled = false },
      panel = {
        enabled = true,
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-j>",
        },
      },
      filetypes = {
        markdown = true,
        gitcommit = true,
        help = true,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local Util = require("util")
      local colors = {
        [""] = Util.fg("Special"),
        ["Normal"] = Util.fg("Special"),
        ["Warning"] = Util.fg("DiagnosticError"),
        ["InProgress"] = Util.fg("DiagnosticWarn"),
      }
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local icon = require("config.icons").kinds.Copilot
          local status = require("copilot.api").status.data
          return icon .. (status.message or "")
        end,
        cond = function()
          local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
          return ok and #clients > 0
        end,
        color = function()
          if not package.loaded["copilot"] then
            return
          end
          local status = require("copilot.api").status.data
          return colors[status.status] or colors[""]
        end,
      })
    end,
  },
  -- copilot cmp source
  {
    "nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          require("util").on_attach(function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter({})
            end
          end)
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })
      opts.sorting = opts.sorting or require("cmp.config.default")().sorting
      table.insert(opts.sorting.comparators, 1, require("copilot_cmp.comparators").prioritize)
    end,
  },
  -- ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    cmd = {
      "ChatGPT",
      "ChatGPTRun",
      "ChatGPTActAs",
      "ChatGPTCompleteCode",
      "ChatGPTEditWithInstructions"
    },
    keys = {
      { "<leader>ai", "<cmd>ChatGPT<cr>", desc = "ChatGPT" },
      { "<leader>ac", "<cmd>ChatGPTCompleteCode<cr>", mode = { "n", "v" }, desc = "ChatGPT Complete Code" },
      { "<leader>ae", "<cmd>ChatGPTEditWithInstructions<cr>", mode = { "n", "v" }, desc = "ChatGPT Edit with Instructions" },
    },
    opts = {
      -- popup_input = {
      --   submit = "<CR>"
      -- }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "Bryley/neoai.nvim",
    enabled = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = {
      "NeoAI",
      "NeoAIContext",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
      "NeoAIShortcut",
    },
    keys = {
      { "<leader>aI", "<cmd>NeoAI<cr>", desc = "AI toggle" },
      { "<leader>aS", desc = "summarize text" },
    },
    opts = {},
    config = function()
      -- highlight AI output as markdown code block
      vim.treesitter.language.register('markdown', 'neoai-output')
      require("neoai").setup {}
    end,
  },
}
