local ftMap = {
  vim = "indent",
  python = { "indent" },
  git = "",
}
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("     %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

local function goPreviousClosedAndPeek()
  require("ufo").goPreviousClosedFold()
  require("ufo").peekFoldedLinesUnderCursor()
end

local function goNextClosedAndPeek()
  require("ufo").goNextClosedFold()
  require("ufo").peekFoldedLinesUnderCursor()
end

return {
  -- make neovim's fold look modern and keep high performance
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    keys = {
      { "zj", function() goNextClosedAndPeek() end, desc = "Go next closed fold", },
      { "zk", function() goPreviousClosedAndPeek() end, desc = "Go previous closed fold", },
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds", },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds", },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds", },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close folds with", },
    },
    config = function()
      require("ufo").setup({
        open_fold_hl_timeout = 150,
        close_fold_kinds = { "imports", "comment" },
        fold_virt_text_handler = handler,
        preview = {
          win_config = {
            -- border = {'', '─', '', '', '', '─', '', ''},
            winhighlight = "Normal:Folded",
            winblend = 0,
          },
          mappings = {
            -- scrollU = '<C-f>',
            -- scrollD = '<C-b>'
          },
        },
        provider_selector = function(bufnr, filetype, buftype)
          -- if you prefer treesitter provider rather than lsp,
          -- return ftMap[filetype] or {'treesitter', 'indent'}
          return ftMap[filetype]
        end,
      })
    end,
  },
}
