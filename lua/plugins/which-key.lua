return {
  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- triggers_blacklist = {
      --   -- list of mode / prefixes that should never be hooked by WhichKey
      --   -- this is mostly relevant for key maps that start with a native binding
      --   -- most people should not need to change this
      --   i = { "i", "j", "k", "h", "u", "v" },
      --   v = { "j", "k" },
      -- },
    },
    config = function(_, opts)
      local Util = require("util")
      local wk = require("which-key")
      wk.setup(opts)

      local normal_keymap = {
        { "<leader>q", ":q!<cr>", desc = "Quit without saving" },
        { "<leader>Q", ":qa!<cr>", desc = "Quit all windows without saving" },
        { "<leader>L", "<cmd>Lazy<cr>", desc = "open lazy.nvim plugins window" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Coding" },
        { "<leader>d", group = "Diff" },
        { "<leader>f", group = "Fuzzy finder" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git Hunk / Hurl" },
        { "<leader>j", group = "Easymotion" },
        { "<leader>l", group = "Url link / LSP" },
        { "<leader>m", group = "Marks / Markdown" },
        { "<leader>n", group = "Notification" },
        { "<leader>r", group = "Replace" },
        { "<leader>s", group = "Session" },
        { "<leader>t", group = "Test" },
        { "<leader>w", group = "Window / Word" },
        { "<leader>x", group = "Trouble" },
        { "<leader>u", group = "Toggle option" },
        { "<leader>ud", function() Util.toggle_diagnostics() end, desc = "Toggle Diagnostics" },
        { "<leader>un", function() Util.toggle("relativenumber") end, desc = "Toggle Line Numbers" },
        { "<leader>us", function() Util.toggle("spell") end, desc = "Toggle Spelling" },
        { "<leader>uw", function() Util.toggle("wrap") end, desc = "Toggle Word Wrap" },
      }

      local global_keymap = {
        { "gc", group = "Comment box" },
        { "go", group = "Go with go.nvim" },
      }

      local visual_keymap = {
        { "<leader>g", group = "Git", mode = "v" },
        { "<leader>r", group = "Refactor", mode = "v" },
      }

      wk.add(normal_keymap)
      wk.add(global_keymap)
      wk.add(visual_keymap)
    end,
  },
}
