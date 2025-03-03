return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = function()
      return {
        library = {
          uv = "luvit-meta/library",
          lazyvim = "LazyVim",
        },
      }
    end,
  },
  -- Manage libuv types with lazy. Plugin will never be loaded
  { "Bilal2453/luvit-meta", lazy = true },
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "quoyi/rails-vscode",
      {
        "benfowler/telescope-luasnip.nvim",
        config = function()
          require("telescope").load_extension("luasnip")
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    end,
  },
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local types = require "cmp.types"

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path", max_item_count = 20 } },
          { { name = "cmdline", max_item_count = 30 } },
          { { name = "cmdline_history", max_item_count = 10 } }
        ),
      })

      return {
        view = {
          entries = { name = "custom", selection_order = "top_down" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-p>"] = cmp.mapping(
            cmp.mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
            { "i", "c" }
          ),
          ["<C-n>"] = cmp.mapping(
            cmp.mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
            { "i", "c" }
          ),
          ["<C-h>"] = function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,
          ["<C-l>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          ["<CR>"] = cmp.mapping.confirm { select = true },
          -- ["<C-y>"] = cmp.mapping {
          --   i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
          --   c = function(fallback)
          --     if cmp.visible() then
          --       cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }
          --     else
          --       fallback()
          --     end
          --   end,
          -- },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { "i", "s", "c" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s", "c" }),
        }),
        sources = cmp.config.sources({
          { name = "path", priority_weight = 100, max_item_count = 40 },
          { name = "nvim_lsp", priority_weight = 85, max_item_count = 50 },
          { name = "buffer", keyword_length = 5 },
          { name = "lazydev", group_index = 0 },
          { name = "luasnip" },
          { name = "nvim_lsp_signature_help" },
        }),
        formatting = {
          format = function(entry, item)
            local icons = require("config.icons").kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            item.menu = ({
              buffer = "[Buf]",
              path = "[Path]",
              luasnip = "[Snip]",
              lazydev = "[Lua]",
              nvim_lsp = "[Lsp]",
              nvim_lsp_signature_help = "[Lsp]",
            })[entry.source.name]
            return item
          end,
        },
        experimental = {
          ghost_text = false,
        },
      }
    end,
  },
}
