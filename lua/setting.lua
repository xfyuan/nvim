local g = vim.g
local cmd = vim.cmd

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

-- ################# Basic settings ################ --

-- ================= Holy leader key ================= --

g.mapleader = ' '

cmd("nnoremap ; :")
cmd("nnoremap : ;")

-- ================= Visualization ================= --

opt("o", "termguicolors", true)
opt("o", "background", 'dark')

-- g.tokyonight_style = "storm"
-- g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- cmd('colorscheme tokyonight')
cmd('colorscheme everforest')
-- vim.api.nvim_command('let g:palenight_terminal_italics=1')

-- ================= Main ================= --

opt("o", "swapfile", false)
opt("b", "swapfile", false)
opt("o", "backup", false)
opt("o", "writebackup", false)
opt("o", "autoread", true)

opt("o", "undofile", true)
opt("o", "undolevels", 1000)
opt("o", "undoreload", 1000)
opt("o", "undodir", vim.fn.stdpath('config') .. '/undo')

opt("o", "ruler", false)
opt("o", "showmode", false)
opt("o", "hidden", true)
-- opt("o", "ignorecase", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("w", "cul", true)

opt("o", "mouse", "a")

opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 1)

opt("o", "updatetime", 250) -- update interval for gitsigns
-- opt("o", "clipboard", "unnamedplus")
opt("o", "timeoutlen", 500)

opt("o", "completeopt", "menuone,noselect")

-- Numbers
opt("w", "number", true)
opt("o", "numberwidth", 4)
-- opt("w", "relativenumber", true)

-- for indenline
opt("b", "expandtab", true)
opt("b", "smartindent", true)
opt("b", "shiftwidth", 2)
opt("b", "tabstop", 2)

opt("o", "foldenable", false)
opt("o", "foldmethod", 'indent')
opt("o", "foldlevel", 1)
-- ================= Useful ================= --
-- remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\s\+$//e]])
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])

-- ================= Utils ================= --
local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end
-- file extension specific tabbing
cmd([[autocmd Filetype python setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]])

return M
