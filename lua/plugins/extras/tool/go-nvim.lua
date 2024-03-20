return {
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    config = function()
      require("go").setup({
        -- NOTE: all LSP and formatting related options are disabeld.
        -- NOTE: is not related to core.plugins.lsp
        -- NOTE: manages LSP on its own
        go = "go", -- go command, can be go[default] or go1.18beta1
        goimport = "gopls", -- goimport command, can be gopls[default] or goimport
        fillstruct = "gopls", -- can be nil (use fillstruct, slower) and gopls
        gofmt = "gofumpt", -- gofmt cmd,
        max_line_len = 120, -- max line length in goline format
        tag_transform = false, -- tag_transfer  check gomodifytags for details
        test_template = "", -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
        test_template_dir = "", -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
        comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ       
        icons = { breakpoint = "🧘", currentpos = "🏃" },
        verbose = false, -- output loginf in messages
        lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
        -- false: do nothing
        -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
        --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
        lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = function(client, bufnr)
          -- attach my LSP configs keybindings
          require("plugins.lsp.keymaps").on_attach(client, bufnr)
          local wk = require("which-key")
          local default_options = { silent = true }
          wk.register({
            o = {
              name = "Go Coding",
              a = { "<cmd>GoCodeAction<cr>", "Code action" },
              e = { "<cmd>GoIfErr<cr>", "Add if err" },
              d = { "<cmd>GoDebug<cr>", "Go debug with dlv" },
              h = {
                name = "Helper",
                a = { "<cmd>GoAddTag<cr>", "Add tags to struct" },
                r = { "<cmd>GoRmTag<cr>", "Remove tags to struct" },
                c = { "<cmd>GoCoverage<cr>", "Test coverage" },
                g = { "<cmd>lua require('go.comment').gen()<cr>", "Generate comment" },
                v = { "<cmd>GoVet<cr>", "Go vet" },
                t = { "<cmd>GoModTidy<cr>", "Go mod tidy" },
                i = { "<cmd>GoModInit<cr>", "Go mod init" },
              },
              i = { "<cmd>GoToggleInlay<cr>", "Toggle inlay" },
              l = { "<cmd>GoLint<cr>", "Run linter" },
              o = { "<cmd>GoPkgOutline<cr>", "Outline" },
              r = { "<cmd>GoRun<cr>", "Run" },
              s = { "<cmd>GoFillStruct<cr>", "Autofill struct" },
              t = {
                name = "Tests",
                -- r = { "<cmd>GoTest -v<cr>", "Run tests" },
                -- t = { "<cmd>GoTestFunc -v<cr>", "Run test for current func" },
                -- f = { "<cmd>GoTestFile -v<cr>", "Run test for current file" },
                a = { "<cmd>GoAddTest<cr>", "Add test for current func" },
                A = { "<cmd>GoAddAllTest<cr>", "Add test for all func" },
                -- s = { "<cmd>GoAltS!<cr>", "Open alt file in split" },
                v = { "<cmd>GoAltV!<cr>", "Open alt file in vertical split" },
              },
              x = {
                name = "Code Lens",
                l = { "<cmd>GoCodeLenAct<cr>", "Toggle Lens" },
                a = { "<cmd>GoCodeAction<cr>", "Code Action" },
              },
            },
          }, { prefix = "g", mode = "n", default_options })
          wk.register({
            o = {
              name = "Go Coding",
              j = { "<cmd>'<,'>GoJson2Struct<cr>", "Json to struct" },
            },
          }, { prefix = "g", mode = "v", default_options })
        end, -- nil: use on_attach function defined in go/lsp.lua,
        --      when lsp_cfg is true
        -- if lsp_on_attach is a function: use this function as on_attach function for gopls
        lsp_codelens = true, -- set to false to disable codelens, true by default
        lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
        lsp_document_formatting = false,
        diagnostic = {  -- set diagnostic to false to disable vim.diagnostic setup
          hdlr = true, -- hook lsp diag handler
          underline = false,
          virtual_text = { space = 0, prefix = '■' },
          signs = true,
          update_in_insert = false,
        },
        -- set to true: use gopls to format
        -- false if you want to use other formatter tool(e.g. efm, nulls)
        lsp_inlay_hints = {
          enable = true,
          -- Only show inlay hints for the current line
          only_current_line = false,
          -- Event which triggers a refersh of the inlay hints.
          -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
          -- not that this may cause higher CPU usage.
          -- This option is only respected when only_current_line and
          -- autoSetHints both are true.
          only_current_line_autocmd = "CursorHold",
          -- whether to show variable name before type hints with the inlay hints or not
          -- default: false
          show_variable_name = true,
          -- prefix for parameter hints
          parameter_hints_prefix = " ",
          show_parameter_hints = true,
          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = "=> ",
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- padding from the right if right_align is true
          right_align_padding = 6,
          -- The color of the hints
          highlight = "Comment",
        },
        gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
        gopls_remote_auto = true, -- add -remote=auto to gopls
        gocoverage_sign = "█",
        dap_debug = true, -- set to false to disable dap
        dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
        -- false: do not use keymap in go/dap.lua.  you must define your own.
        dap_debug_gui = false, -- set to true to enable dap gui, highly recommended
        dap_debug_vt = { enabled_commands = true, all_frames = true }, -- set to true to enable dap virtual text
        build_tags = "", -- set default build tags
        textobjects = true, -- enable default text jobects through treesittter-text-objects
        test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
        run_in_floaterm = false, -- set to true to run in float window.
        -- float term recommended if you use richgo/ginkgo with terminal color
        luasnip = true,
      })
    end,
  },
}
