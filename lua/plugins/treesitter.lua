local swap_next, swap_prev = (function()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    c = "@class.outer",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<leader>cx%s", key)] = obj
    p[string.format("<leader>cX%s", key)] = obj
  end

  return n, p
end)()

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/playground" },
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = { mode = "cursor", max_lines = 3 },
      },
      { "RRethy/nvim-treesitter-textsubjects" },
      { "RRethy/nvim-treesitter-endwise" },
      { "windwp/nvim-ts-autotag", config = true },
    },
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      sync_install = false,
      ensure_installed = {
        "bash",
        "cmake",
        "css",
        "html",
        "http",
        "markdown",
        "markdown_inline",
        "jsdoc",
        "lua",
        "regex",
        "scss",
        "toml",
        "vim",
        "vue",
      },
      highlight = {
        enable = true,
        disable = function(_, bufnr) -- Disable in large buffers
          -- return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 5000
          return vim.api.nvim_buf_line_count(bufnr) > 5000
        end,
      },
      indent = { enable = true, disable = { "ruby" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = swap_next,
          swap_previous = swap_prev,
        },
        lsp_interop = {
          enable = true,
          border = "rounded",
          peek_definition_code = {
            ["<leader>da"] = "@function.outer",
            ["<leader>dA"] = "@class.outer",
          },
        },
      },
      textsubjects = {
        enable = true,
        prev_selection = ",", -- (Optional) keymap to select the previous selection
        keymaps = {
          ["."] = "textsubjects-smart",
          [";"] = "textsubjects-container-outer",
          ["i;"] = "textsubjects-container-inner",
        },
      },
      refactor = {
        highlight_definitions = { enable = false },
        highlight_current_scope = { enable = false },
        navigation = { enable = true },
        smart_rename = { enable = true },
      },
      matchup = {
        enable = true,
      },
      playground = {
        enable = true,
        updatetime = 25,
        persist_queries = false,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      endwise = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
