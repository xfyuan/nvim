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

opt("o", "sessionoptions", 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal')

-- ================= Useful ================= --
-- remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\s\+$//e]])
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])
