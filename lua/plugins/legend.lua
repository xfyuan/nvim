return {
  -- Tim Pope ⭐
  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = { "BufReadPre", "BufNewFile" } },
  -- pairs of handy bracket mappings, like ]n jumpt to SCM conflict
  { "tpope/vim-unimpaired", event = { "BufReadPre", "BufNewFile" } },
  -- automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
  { "tpope/vim-sleuth", event = { "BufReadPre", "BufNewFile" } },
  -- switch case using crc, crs, crm, etc.
  { "tpope/vim-abolish", event = { "BufReadPre", "BufNewFile" } },
  -- { "tpope/vim-surround", event = "BufReadPre" },
  -- { "tpope/vim-rails", event = "VeryLazy" },
  {
    "tpope/vim-rails",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- disable autocmd set filetype=eruby.yaml
      vim.api.nvim_create_autocmd(
        { 'BufNewFile', 'BufReadPost' },
        {
          pattern = { '*.yml' },
          callback = function()
            vim.bo.filetype = 'yaml'
          end
        }
      )
    end
  },
  {
    "tpope/vim-fugitive",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
    dependencies = {
      "tpope/vim-rhubarb",
    },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
      -- { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
      { "<leader>gr", "<cmd>Gread<cr>", desc = "Git Read" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
      { "<leader>gc", "<cmd>Git commit --verify<cr>", desc = "Git Commit" },
    },
  },
  -- {
  --   "tpope/vim-dadbod",
  --   dependencies = {
  --     { "kristijanhusak/vim-dadbod-ui" },
  --     { "kristijanhusak/vim-dadbod-completion" },
  --   },
  -- },

  -- Junegunn Choi ⭐
  -- { "junegunn/fzf", event = "VeryLazy", build = ":call fzf#install()" },
  -- { "junegunn/fzf.vim", event = "VeryLazy" },
  -- "junegunn/vim-fnr", -- Find-N-Replace in Vim with live preview
  -- { "junegunn/gv.vim", event = "VeryLazy" },
}
