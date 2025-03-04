-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
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
      { "<leader>e", "<cmd>Oil<cr>", mode = { "n" }, desc = "Oil explorer" },
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
        -- ["<CR>"] = "actions.select",
        ["O"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["<C-y>"] = "actions.yank_entry",
        -- ["-"] = { "actions.parent", mode = "n" },
        ["U"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gS"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        -- copy relative path
        ["gy"] = {
          callback = function()
            local oil = require "oil"
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()

            if not entry or not dir then
              return
            end

            local relpath = vim.fn.fnamemodify(dir, ":.")
            vim.fn.setreg("+", relpath .. entry.name)
          end,
        },
        -- search and replace in the current directory
        ["gs"] = {
          callback = function()
            local oil = require "oil"
            -- get the current directory
            local prefills = { paths = oil.get_current_dir() }
            local grug_far = require "grug-far"
            -- instance check
            if not grug_far.has_instance "explorer" then
              grug_far.open {
                instanceName = "explorer",
                prefills = prefills,
                staticTitle = "Find and Replace from Explorer",
              }
            else
              grug_far.open_instance "explorer"
              -- updating the prefills without clearing the search and other fields
              grug_far.update_instance_prefills("explorer", prefills, false)
            end
          end,
          desc = "oil: Search in directory",
        },
      },
    },
  },
}
