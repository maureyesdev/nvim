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

----------------------------------------------------------------------------
-- INSERT
----------------------------------------------------------------------------
-- Press fd fast to escape
-- keymap.set("i", "fd", "<ESC>", opts)

----------------------------------------------------------------------------
-- VISUAL
----------------------------------------------------------------------------
-- Press fd fast to escape
-- keymap.set("v", "fd", "<ESC>", opts)

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

----------------------------------------------------------------------------
-- TERM
----------------------------------------------------------------------------
-- Press fd fast to escape
-- keymap.set("t", "fd", "<ESC>", opts)

----------------------------------------------------------------------------
-- COMMAND
----------------------------------------------------------------------------
-- Press fd fast to escape
-- keymap.set("c", "fd", "<ESC>", opts)

----------------------------------------------------------------------------
-- TELESCOPE KEYMAPS
----------------------------------------------------------------------------
-- Description: Find files in current directory
-- Keymap: leader + p
keymap.set("n", "<leader>p", function()
  require("telescope.builtin").find_files(
    require("telescope.themes").get_dropdown({ previewer = false })
  )
end, opts)

-- Description: Search input in current directory files
-- Keymap: leader + ff
keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").live_grep({ theme = "ivy" })
end, opts)

-- Description: Search input in current file
-- Keymap: leader + f + s
keymap.set("n", "<leader>fs", function()
  require("telescope.builtin").current_buffer_fuzzy_find(
    require("telescope.themes").get_dropdown({ previewer = false })
  )
end, opts)

-- Description: Go to definition
-- Keymap: leader + g + d
keymap.set("n", "<leader>gd", function()
  require("telescope.builtin").lsp_definitions({ reuse_win = true })
end, opts)

-- Description: Go to references
-- Keymap: leader + g + r
keymap.set("n", "<leader>gr", function()
  require("telescope.builtin").lsp_references()
end, opts)

-- Description: Go to symbol
-- Keymap: leader + g + s
keymap.set("n", "<leader>gs", function()
  require("telescope.builtin").lsp_document_symbols()
end, opts)


-- Description: Show hover specification
-- Keymap: leader + k
keymap.set("n", "<leader>k", function()
  vim.lsp.buf.hover()
end, opts)

-- Description: Code action
-- Keymap: leader + c + a
keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, opts)

-- Description: Rename current input
-- Keymap: leader + c + r
keymap.set("n", "<leader>cr", function()
  vim.lsp.buf.rename()
end, opts)

-- Description: Show spell suggestions
-- Keymap: leader + s + s
keymap.set("n", "<leader>ss", function()
  require("telescope.builtin").spell_suggest(
    require("telescope.themes").get_cursor({})
  )
end, opts)

--
keymap.set("n", "<leader>e", function()
  require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
end, opts)
