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
        k = { "<Plug>DashSearch", "Search word in Dash" }, -- dash.vim plugin
        L = { "<cmd>Lazy<cr>", "open lazy.nvim plugins window" },
        o = { "<cmd>AerialToggle<cr>", "Toggle code outline window" }, -- aerial.nvim plugin
        -- Database
        D = {
          name = "Database",
          u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
          f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
          r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
          q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
        },
        d = {
          name = "Debugger/Diff/DB/Buffer",
          f = {
            name = "Diff view",
            o = { "<cmd>DiffviewOpen<CR>", "Open diffview" },
            u = { "<cmd>DiffviewOpen -uno<CR>", "Open diffview hide untracked files" },
            h = { "<cmd>DiffviewFileHistory<CR>", "Open diffview file history" },
          },
          -- vim-dadbod plugin
          -- u = {'<cmd>DBUI<cr>', 'open db ui'},
          -- l = {'<Plug>(DBExeLine)', 'run line as query'},
          -- g = { function() require('dapui').toggle() end, "Toggle debbuger" },
          b = { function() require("dap").toggle_breakpoint() end, "Toggle breakpoint", },
          c = { function() require("dap").continue() end, "Continue or start debuggger", },
          n = { function() require("dap").step_over() end, "Step over", },
          i = { function() require("dap").step_into() end, "Step in", },
          o = { function() require("dap").step_out() end, "Step out", },
          k = { function() require("dap").up() end, "Go up", },
          j = { function() require("dap").down() end, "Go down", },
          u = { function() require("dapui").toggle() end, "Toggle UI", },
          t = {
            function()
              local dap = require("dap")
              dap.run({
                type = "go",
                name = "",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}",
                args = { "-test.run", "" },
              })
            end,
            "Debug test",
          },
        },
        f = {
          name = "Fuzzy finder",
          -- fzf.vim
          -- b = {'<cmd>Buffers<cr>', 'find buffers'},
          -- o = {'<cmd>History<cr>', 'find old history'},
          g = { "<cmd>GFiles<cr>", "Fzf find git files" },
          j = { "<cmd>Files<cr>", "Fzf find files" },
          -- telescope
          b = { "<cmd>Telescope buffers<cr>", "Switch buffers" },
          h = { "<cmd>Telescope oldfiles<cr>", "Opened files history" },
          s = { "<cmd>Telescope luasnip<cr>", "Search snippet" },
          p = { "<cmd>Telescope lazy<cr>", "List lazy plugins info" },
          P = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "Find project" },
        },
        g = {
          name = "Git",
          -- telescope
          l = { "<cmd>Telescope git_status<cr>", "Changed files" },
          m = { "<cmd>Telescope git_commits<cr>", "Find git commits" },
          -- vim-fugitive plugin
          g = { "<cmd>Git blame<cr>", "Blame" },
          s = { "<cmd>Git<cr>", "Status" },
          -- l = {'<cmd>GFiles?<cr>', 'changed files'},
          d = { "<cmd>Gdiff<cr>", "Diff" },
          r = { "<cmd>Gread<cr>", "Read" },
          -- w = {'<cmd>Gwrite<cr>', 'write'},
          p = { "<cmd>Git push<cr>", "Push" },
          c = { "<cmd>Gcommit -v<cr>", "Commit" },
          -- gitsigns plugin
          b = { "<cmd>lua require 'gitsigns'.blame_line({ full = true })<cr>", "Blame Line" },
          j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
          k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
          a = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
          u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
          P = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
          A = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
          R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
          D = { "<cmd>lua require 'gitsigns'.diffthis()<cr>", "Diff This" },
          w = { "<cmd>lua require 'gitsigns'.diffthis('~')<cr>", "Diff This ~" },
          -- vim-rhubarb plugin
          -- b = {'<cmd>Gbrowser<cr>', 'browse github'},
          -- gv.vim plugin
          h = { "<cmd>GV!<cr>", "List only current file commits" },
        },
        r = {
          name = "Replace/Refactor",
          -- Spectre
          r = { [[<cmd>lua require('spectre').open_visual({select_word=true})<cr>]], "Replace cursor word" },
          f = { [[viw:lua require('spectre').open_file_search()<cr>]], "Replace in current file" },
          o = { [[<cmd>lua require('spectre').open()<CR>]], "Open spectre" },
          -- Refactoring
        },
        s = {
          name = "Search/Session",
          -- search
          -- c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
          C = { "<cmd>Telescope commands<cr>", "Commands" },
          h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
          H = { "<cmd>Telescope heading<cr>", "Find Header" },
          m = { "<cmd>Telescope marks<cr>", "Find Mark" },
          M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
          r = { "<cmd>Telescope registers<cr>", "Registers" },
          t = { "<cmd>Telescope live_grep<cr>", "Text" },
          s = { "<cmd>Telescope grep_string<cr>", "Text under cursor" },
          S = { "<cmd>Telescope symbols<cr>", "Search symbols" },
          k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
          -- session
          a = { "<cmd>SaveSession<cr>", "Add auto session" },
          l = { "<cmd>RestoreSession<cr>", "Load auto session" },
          d = { "<cmd>DeleteSession<cr>", "Delete auto session" },
          f = { "<cmd>SearchSession<cr>", "Search auto session" },
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
          w = { "<cmd>FocusMaxOrEqual<cr>", "Toggle window zoom" },
          s = { "<cmd>FocusSplitNicely<cr>", "Split a window on golden ratio" },
          o = { "<cmd>lua require('nvim-window').pick()<cr>", "Choose window" },
          t = { "<c-w>t", "Move to new tab" },
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
          B = { "<cmd>CBcbox10<CR>", "Comment box ascii" },
        },
        o = {
          name = "Go with go.nvim",
          a = { "<cmd>GoAlt<CR>", "Alternate impl and test" },
          i = { "<cmd>GoInstall<CR>", "Go install" },
          b = { "<cmd>GoBuild<CR>", "Go build" },
          d = { "<cmd>GoDoc<CR>", "Go doc" },
          f = { "<cmd>GoFmt<cr>", "Formatting code" },
          r = { "<cmd>!go run %:.<CR>", "Go run current file" },
          e = { "<cmd>GoIfErr<CR>", "Add if err" },
          w = { "<cmd>GoFillSwitch<CR>", "Fill switch" },
          g = { "<cmd>GoAddTag<CR>", "Add json tag" },
          c = { "<cmd>lua require('go.comment').gen()<CR>", "Comment current func" },
        },
      }

      wk.register(normal_keymap, n_opts)
      wk.register(visual_keymap, v_opts)
      wk.register(global_keymap, g_opts)
    end,
  },
}
