return {
  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "i", "j", "k", "h", "u", "v" },
        v = { "j", "k" },
      },
    },
    config = function(_, opts)
      local Util = require("util")
      local wk = require("which-key")
      wk.setup(opts)

      local n_opts = { mode = "n", prefix = "<leader>" }
      local v_opts = { mode = "v", prefix = "<leader>" }
      local g_opts = { mode = "n", prefix = "g" }

      local normal_keymap = {
        -- ['<leader>'] = {'<cmd>GitFiles<cr>', 'find git files'},
        -- ['1'] = {':normal "lyy"lpwv$r=^"lyyk"lP<cr>', 'mark ======'},
        q = { ":q!<cr>", "Quit without saving" },
        Q = { ":qa!<cr>", "Quit all windows without saving" },
        L = { "<cmd>Lazy<cr>", "open lazy.nvim plugins window" },
        b = {
          name = "Buffer",
        },
        d = {
          name = "Diff",
        },
        f = {
          name = "Fuzzy finder",
        },
        g = {
          name = "Git",
        },
        h = {
          name = "Git Hunk / Hurl",
        },
        j = {
          name = "Easymotion",
        },
        l = {
          name = "Url link / LSP",
        },
        r = {
          name = "Replace",
        },
        s = {
          name = "Session",
        },
        t = {
          name = "Test",
        },
        u = {
          name = "Toggle option",
          w = { function() Util.toggle("wrap") end, "Toggle Word Wrap", },
          s = { function() Util.toggle("spell") end, "Toggle Spelling", },
          n = { function() Util.toggle("relativenumber") end, "Toggle Line Numbers", },
          d = { function() Util.toggle_diagnostics() end, "Toggle Diagnostics", },
        },
        w = {
          name = "Window / Word",
        },
      }

      local visual_keymap = {
        g = {
          name = "Git",
        },
        r = {
          name = "Refactor",
        },
      }

      local global_keymap = {
        c = {
          name = "Comment box",
        },
        o = {
          name = "Go with go.nvim",
        },
      }

      wk.register(normal_keymap, n_opts)
      wk.register(visual_keymap, v_opts)
      wk.register(global_keymap, g_opts)
    end,
  },
}
