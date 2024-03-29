return {
  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
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
        -- k = { "<Plug>DashSearch", "Search word in Dash" }, -- dash.vim plugin
        L = { "<cmd>Lazy<cr>", "open lazy.nvim plugins window" },
        O = { "<cmd>AerialToggle<cr>", "Toggle code outline window" }, -- aerial.nvim plugin
        b = {
          name = "Buffer/Bot",
          c = { function() require("util.bot").cht() end, "Cheatsheet(cht.sh)", },
          s = { function() require("util.bot").stackoverflow() end, "Stack Overflow", },
        },
        -- Database
        -- D = {
        --   name = "Database",
        --   u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
        --   f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
        --   r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
        --   q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
        -- },
        d = {
          name = "Diff/Debug",
          f = {
            name = "Diff view",
            o = { "<cmd>DiffviewOpen<CR>", "Open diffview" },
            c = { "<cmd>DiffviewClose<CR>", "Close diffview" },
            u = { "<cmd>DiffviewOpen -uno<CR>", "Open diffview hide untracked files" },
            h = { "<cmd>DiffviewFileHistory<CR>", "Open diffview file history" },
            s = { "<cmd>lua require'telescope'.extensions.diff.diff_current({ hidden = true })<cr>", "Compare file with current" },
            S = { "<cmd>lua require'telescope'.extensions.diff.diff_files({ hidden = true })<cr>", "Compare 2 files" },
          },
        },
        f = {
          name = "Fuzzy finder",
          -- telescope
          a = { "<cmd>Telescope telescope-alternate alternate_file<cr>", "Alternate file" },
          b = { "<cmd>Telescope buffers<cr>", "Switch buffers" },
          h = { "<cmd>Telescope frecency<cr>", "Most (f)recently used files" },
          j = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find current buffer" },
          m = { "<cmd>MarksListBuf<cr>", "Find Mark in buffer" },
          d = { "<cmd>Telescope diagnostics<cr>", "Find Diagnostics" },
          r = { "<cmd>Telescope registers<cr>", "Find Registers" },
          k = { "<cmd>Telescope keymaps<cr>", "Find Keymaps" },
          g = { "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args({default_text=vim.fn.expand('<cword>')})<cr>", "Grep cursor word with args" },
          t = { "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args()<cr>", "Grep text with args" },
          p = { "<cmd>Telescope lazy<cr>", "List lazy plugins info" },
          P = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "Find project" },
          s = { "<cmd>Telescope luasnip<cr>", "Search snippet" },
          e = {
            name = "Extra finder",
            C = { "<cmd>Telescope commands<cr>", "Commands" },
            h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
            H = { "<cmd>Telescope heading<cr>", "Find Header" },
            M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
            S = { "<cmd>Telescope symbols<cr>", "Search emoj symbols" },
          }
        },
        g = {
          name = "Git",
          -- telescope
          l = { "<cmd>Telescope git_status<cr>", "Changed files" },
          -- vim-fugitive plugin
          s = { "<cmd>Git<cr>", "Status" },
          -- d = { "<cmd>Gdiff<cr>", "Diff" },
          r = { "<cmd>Gread<cr>", "Read" },
          p = { "<cmd>Git push<cr>", "Push" },
          c = { "<cmd>Git commit --verify<cr>", "Commit" },
          -- gitsigns plugin
          b = { "<cmd>lua require 'gitsigns'.blame_line({ full = true })<cr>", "Blame Line" },
          j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
          k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
          a = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
          A = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
          d = { "<cmd>lua require 'gitsigns'.diffthis()<cr>", "Diff This" },
          e = {
            name = "Extra action",
            b = { "<cmd>Git blame<cr>", "Blame" },
            m = { "<cmd>Telescope git_commits<cr>", "Find git commits" },
            L = { "<cmd>Telescope advanced_git_search search_log_content<cr>", "Search in repo log content" },
            l = { "<cmd>Telescope advanced_git_search search_log_content_file<cr>", "Search in file log content" },
            d = { "<cmd>lua require 'gitsigns'.diffthis('~')<cr>", "Diff This ~" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
            -- gv.vim plugin
            h = { "<cmd>GV!<cr>", "List current file commits history" },
            -- vim-rhubarb plugin
            -- b = {'<cmd>Gbrowser<cr>', 'browse github'},
          },
        },
        j = {
          name = "Easymotion",
          -- hop.nvim
          -- flash.nvim
        },
        r = {
          name = "Replace",
          -- Spectre
          r = { [[<cmd>lua require('spectre').open_visual({select_word=true})<cr>]], "Replace cursor word" },
          f = { [[viw:lua require('spectre').open_file_search()<cr>]], "Replace in current file" },
          o = { [[<cmd>lua require('spectre').open()<CR>]], "Replace in files" },
        },
        s = {
          name = "Session",
        },
        t = {
          name = "Test",
          -- vim-test plugin
        },
        u = {
          name = "Url view/Toggle option",
          -- urlview
          u = { "<cmd>UrlView buffer<cr>", "Find URL and open" },
          l = { "<cmd>UrlView buffer action=clipboard<cr>", "Copy URL" },
          -- toggle options
          f = { function() require("plugins.lsp.format").toggle() end, "Toggle format on Save", },
          w = { function() Util.toggle("wrap") end, "Toggle Word Wrap", },
          s = { function() Util.toggle("spell") end, "Toggle Spelling", },
          n = { function() Util.toggle("relativenumber") end, "Toggle Line Numbers", },
          d = { function() Util.toggle_diagnostics() end, "Toggle Diagnostics", },
        },
        w = {
          name = "Window/Word",
          f = { "<cmd>FocusToggle<cr>", "Toggle window focus" },
          F = { "<cmd>FocusToggleWindow<cr>", "Toggle window focus again on per window" },
          w = { "<cmd>FocusMaxOrEqual<cr>", "Toggle window zoom" },
          s = { "<cmd>FocusSplitNicely<cr>", "Split a window on golden ratio" },
          o = { "<cmd>lua require('nvim-window').pick()<cr>", "Choose window" },
          m = { "<cmd>MarkdownPreview<cr>", "Open markdown preview window" },
          l = { "<Plug>TranslateW", "Translate word online" },
          -- w = {'<cmd>MacDictPopup<cr>', 'search cursor word in macOS distionary'},
          -- d = {'<cmd>MacDictWord<cr>', 'search in macOS distionary and show in quickfix'},
        },
      }

      local visual_keymap = {
        g = {
          name = "Git",
          Y = {
            "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
            "Open permalinks of selected area",
          },
        },
        r = {
          name = "Refactor",
        },
      }

      local global_keymap = {
        c = {
          name = "Comment box",
          B = { "<cmd>CBccbox10<CR>", "Comment box ascii" },
        },
        o = {
          name = "Go with go.nvim",
          -- go.nvim
        },
      }

      wk.register(normal_keymap, n_opts)
      wk.register(visual_keymap, v_opts)
      wk.register(global_keymap, g_opts)
    end,
  },
}
