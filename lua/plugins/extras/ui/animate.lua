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
          timing = animate.gen_timing.linear({ duration = 66, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        },
      }
    end,
  },
  -- Whenever cursor jumps some distance or moves between windows, it will flash so you can see where it is
  {
    "danilamihailov/beacon.nvim",
    event = "VeryLazy",
  },
}
