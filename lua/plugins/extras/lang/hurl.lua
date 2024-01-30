vim.cmd([[autocmd BufRead,BufNewFile *.hurl* set filetype=hurl]])
vim.cmd([[set commentstring=#\ %s]])

return {
  -- add hurl to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "hurl" })
    end,
  },
  -- run HTTP requests directly from `.hurl` files.
  -- executing and viewing API responses without leaving editor
  {
    "jellydn/hurl.nvim",
    opts = {
      -- Show response in popup or split
      mode = "split",
      auto_close = false,
    },
    keys = {
      -- Run API request
      { "<leader>hh", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
      { "<leader>ha", "<cmd>HurlRunnerAt<CR>", desc = "Run current line Api request" },
      { "<leader>he", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      { "<leader>hm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
      { "<leader>hv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>hh", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
    },
  },
}
