-- Modes
-- NORMAL - "n"
-- INSERT - "i"
-- VISUAL - "v"
-- BLOCK_VISUAL- "x"
-- TERM - "t"
-- COMMAND - "c"

local opts = { noremap = true, silent = true }

-- Remap space as leader key
local keymap = vim.keymap

-- Remap space as leader key
keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------------------------------------------------------------------------
-- NORMAL
----------------------------------------------------------------------------
-- Better window navigation
-- Ctrl + h | j | k | l
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers -- ? CAN THIS BE <TAB> and <S-TAB> INSTEAD?
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- TODO: Need some keymaps to split horizontally and vertically

----------------------------------------------------------------------------
-- INSERT
----------------------------------------------------------------------------
-- Press fd fast to escape
-- TODO: CURRENTLY THIS DOES NOT WORK FOR CMDLINE APPARANTLY
keymap.set("i", "fd", "<ESC>", opts)

-- TODO: IS there a better way to delete backwards?


----------------------------------------------------------------------------
-- VISUAL
----------------------------------------------------------------------------
-- Press fd fast to escape
keymap.set("v", "fd", "<ESC>", opts)

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- For regular copy and paste behavior, Neovim will override the buffer text if you copy and use dd.
-- With this it will still conserve the previus buffer text
keymap.set("v", "p", '"_dP', opts)

----------------------------------------------------------------------------
-- BLOCK VISUAL
----------------------------------------------------------------------------
-- Move selection up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
