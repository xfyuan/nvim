local Util = require("lazy.core.util")
local function toggle_animation()
  vim.g.minianimate_disable = not vim.g.minianimate_disable
  if vim.g.minianimate_disable then
    Util.warn("Disabled mini automation", { title = "Animation" })
  else
    Util.info("Enabled mini automation", { title = "Animation" })
  end
end

return {
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    keys = {
      { "<leader>ua", function() toggle_animation() end, desc = "Toggle animation" },
    },
    opts = function()
      local animate = require("mini.animate")
      return {
        cursor = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
          path = animate.gen_path.line({
            predicate = function(destination) return destination[1] < -2 or 2 < destination[1] end,
          }),
        },
        resize = {
          timing = animate.gen_timing.linear({ duration = 10, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        },
      }
    end,
  },
  -- Flash cursor when jumps or moves between windows
  {
    "rainbowhxch/beacon.nvim",
    event = "VeryLazy",
    config = function()
      require('beacon').setup({
        focus_gained = true,
      })
    end,
  },
}
