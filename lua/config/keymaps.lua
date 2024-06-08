local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap("n", "j", "gj", { silent = true })
keymap("n", "k", "gk", { silent = true })
-- Go to beginning of line. Goes to previous line if repeated
keymap("n", "H", "getpos('.')[2] == 1 ? 'k' : '^'", { expr = true })
-- Go to end of line. Goes to next line if repeated
keymap("n", "L", "len(getline('.')) == 0 || len(getline('.')) == getpos('.')[2] ? 'jg_' : 'g_'", { expr = true })

-- core useful
keymap("n", "<leader><leader>", "<c-^>") -- Switch between 2 buffers
keymap("n", "<TAB>", "%")
vim.cmd('nnoremap <leader>p "*p') -- Paste content from OS's clipboard
vim.cmd('vnoremap <leader>y "*y') -- Yank content in OS's clipboard
vim.cmd("nnoremap <Enter> o<ESC>") -- Insert New Line quickly

-- Better viewing
-- keymap("n", "n", "nzzzv")
-- keymap("n", "N", "Nzzzv")
-- keymap("n", "g,", "g,zvzz")
-- keymap("n", "g;", "g;zvzz")

-- Better escape using jk in insert and terminal mode
keymap("i", "jj", "<ESC>")
keymap("t", "jj", "<C-\\><C-n>")
-- keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
-- keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
-- keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
-- keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- tabs
keymap("n", "<leader><tab>", "<cmd>tabnext<cr>")

-- Quick split window
keymap("n", "_", [[<Cmd>sp<CR>]])
keymap("n", "<bar>", [[<Cmd>vsp<CR>]])
-- Vertical split and resize window to be golden radio!!
-- keymap("n", "<leader>ws", "<cmd>vsp<CR><cmd>vertical resize +25<CR>")
-- keymap("n", "<leader>we", "<c-w>=")
-- keymap("n", "<leader>wf", "<cmd>vertical resize +25<CR>")

-- Resize window using <shift> arrow keys
keymap("n", "<A-Up>", "<cmd>resize +5<CR>")
keymap("n", "<A-Down>", "<cmd>resize -5<CR>")
keymap("n", "<A-Left>", "<cmd>vertical resize -5<CR>")
keymap("n", "<A-Right>", "<cmd>vertical resize +5<CR>")

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
-- keymap("v", "<", "<gv")
-- keymap("v", ">", ">gv")

-- Paste over currently selected text without yanking it
-- keymap("v", "p", '"_dP')

-- Yank and paste
keymap("n", "Y", "y$") -- Yanking to the end of line
-- keymap("n", "p", "p`[") -- Paste yank after, keep cursor position
-- keymap("n", "P", "P`[") -- Paste yank before, keep cursor position

-- Input shortcuts
keymap("i", "uu", "_")
keymap("i", "hh", "-")
keymap("i", "ii", "=")
keymap("i", "kk", "->")
keymap("i", "jk", "=>")
-- keymap("i", "vv", "<bar>>")
keymap("i", "vv", ":=")

-- Move Lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Toggle diff two buffers
keymap("n", "<leader>dF", "&diff ? ':windo diffoff<cr>' : ':windo diffthis<cr>'", { expr = true })

--          +-----------------------------------------------------------------------------+
--          |                               EXTRA KEYMAP TIPS                             |
--          +-----------------------------------------------------------------------------+

-- go back the original place from jumping to definitions like ctags
keymap("n", "<BS>", "<C-o>")

-- repeat or execute macro on all visually selected lines
-- (eg. press A"<esc> on line one, select all others, press . and they all end in "
keymap("x", ".", ":norm .<CR>")
keymap("x", "@", ":norm @q<CR>")

-- Reload snippets folder
keymap("n", "<leader>sr", "<cmd>source ~/.config/nvim/snippets/*<cr>", { desc = "Reload snippets" })
