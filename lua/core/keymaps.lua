local opts = { noremap = true, silent = true }

-- Remap space as leader key
local keymap = vim.keymap

-- Remap space as leader key
keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- DISABLING F1 key
vim.keymap.set({ "n", "i", "v" }, "<F1>", "<Nop>", { silent = true })

----------------------------------------------------------------------------
-- NORMAL
----------------------------------------------------------------------------
-- Better window navigation
-- Ctrl + h | j | k | l
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Ctrl + h | j | k | l FOR TMUX
vim.api.nvim_set_keymap("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", opts)

-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize +20<CR>", opts)
keymap.set("n", "<C-Down>", ":resize -20<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -20<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +20<CR>", opts)

keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Increment and decrement
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "-", "<C-x>", opts)

-- Select all
keymap.set("n", "<Leader>aa", "gg<S-v>G", opts)

-- Split windows
keymap.set("n", "<Leader>sh", ":split<CR>", opts)
keymap.set("n", "<Leader>sv", ":vsplit<CR>", opts)

-- Quit all
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", opts)

-- Utility to treat wrap line as independent line when going down and up
vim.keymap.set(
  "n",
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
vim.keymap.set(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

----------------------------------------------------------------------------
-- INSERT
----------------------------------------------------------------------------

----------------------------------------------------------------------------
-- VISUAL
----------------------------------------------------------------------------

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- For regular copy and paste behavior, Neovim will override the buffer text if you copy and use dd.
-- With this it will still conserve the previous buffer text
-- TODO: Need to double check this, 'cause I thing is not working
keymap.set("v", "p", '"_dP', opts)

----------------------------------------------------------------------------
-- BLOCK VISUAL
----------------------------------------------------------------------------
-- Move selection up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)

keymap.set("n", "<Esc>", function()
  if vim.v.hlsearch == 1 then
    vim.cmd("nohlsearch")
  end
end, { noremap = true, silent = true })

