return {
  {
    "voldikss/vim-translator",
    event = "VeryLazy",
  }, -- Asynchronous translating plugin
  -- {
  --   "potamides/pantran.nvim", -- Use your favorite machine translation engines without having to leave your favorite editor
  --   config = function()
  --     require("pantran").setup({
  --       default_engine = "google",
  --     })
  --     local opts = { noremap = true, silent = true, expr = true }
  --     vim.keymap.set("n", "<leader>tr", function()
  --       return require("pantran").motion_translate() .. "_"
  --     end, opts)
  --     vim.keymap.set("x", "<leader>tr", require("pantran").motion_translate, opts)
  --   end,
  -- },
}
