-- customize fold text
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
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
      table.insert(newVirtText, {chunkText, hlGroup})
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, {suffix, 'MoreMsg'})
  return newVirtText
end
-- add folds for blocks of comments
local function get_comment_folds(bufnr)
  local comment_folds = {}
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local is_in_comment = false
  local comment_start = 0

  for i = 0, line_count - 1 do
    local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
    if not is_in_comment and line:match('^%s*' .. vim.o.commentstring:sub(1, 1)) then
      is_in_comment = true
      comment_start = i
    elseif is_in_comment and not line:match('^%s*' .. vim.o.commentstring:sub(1, 1)) then
      is_in_comment = false
      table.insert(comment_folds, {startLine = comment_start, endLine = i - 1})
    end
  end

  if is_in_comment then
    table.insert(comment_folds, {startLine = comment_start, endLine = line_count - 1})
  end

  return comment_folds
end

local function treesitter_and_comment_folding(bufnr)
  local comment_folds = get_comment_folds(bufnr)
  local treesitter_folds = require('ufo').getFolds(bufnr, "treesitter")
  if vim.bo.filetype ~= "help" then
    for _, fold in ipairs(comment_folds) do
      table.insert(treesitter_folds, fold)
    end
  end
  return treesitter_folds
end

return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async'
  },
  event = "BufRead",
  keys = {
    { "zR", function() require('ufo').openAllFolds() end, desc = "Open all folds" },
    { "zM", function() require('ufo').closeAllFolds() end, desc = "Close all folds" },
    { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds with", },
    { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close folds with", },
    { "zj", function() require("ufo").goNextClosedFold() end, desc = "Go to next closed fold", },
    { "zk", function() require("ufo").goPreviousClosedFold() end, desc = "Go to previous closed fold", },
    { "zp", function() require('ufo').peekFoldedLinesUnderCursor() end, desc = "Preview folded lines under cursor" },
  },
  opts = {
    open_fold_hl_timeout = 150,
    fold_virt_text_handler = handler,
    provider_selector = function(bufnr, filetype, buftype)
      return treesitter_and_comment_folding
    end,
    preview = {
      win_config = {
        border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
        winblend = 0,
        winhighlight = "Normal:LazyNormal",
      }
    }
  },
}
