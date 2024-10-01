-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local dir = require("oil").get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  {
    'stevearc/oil.nvim',
    dependencies = {
      { "SirZenith/oil-vcs-status" },
    },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", mode = { "n" }, desc = "File explorer" },
    },
    opts = {
      use_default_keymaps = false,
      skip_confirm_for_simple_edits = true,
      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
        signcolumn = "number",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["<C-y>"] = "actions.yank_entry",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    },
  },
}
