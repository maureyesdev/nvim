local variables = require("config.variables")
vim.g.tmux_navigator_no_mappings = 0

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
if variables.normalized_line_wrap == true then
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
end

----------------------------------------------------------------------------
-- INSERT
----------------------------------------------------------------------------
-- Press fd fast to escape
keymap.set("i", "fd", "<ESC>", opts) -- ? Am I really using this?

----------------------------------------------------------------------------
-- VISUAL
----------------------------------------------------------------------------
-- Press fd fast to escape
-- keymap.set("v", "fd", "<ESC>", opts)

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
  require("telescope.builtin").find_files()
end, opts)

-- Description: Search input in current directory files
-- Keymap: leader + ff
keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").live_grep()
end, opts)

-- Description: Search input in current file
-- Keymap: leader + f + s
keymap.set("n", "<leader>fs", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, opts)

-- Description: Go to definition
-- Keymap: leader + g + d
keymap.set("n", "<leader>gd", function()
  require("telescope.builtin").lsp_definitions()
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

-- Description: Show spell suggestions
-- Keymap: leader + s + s
keymap.set("n", "<leader>ss", function()
  require("telescope.builtin").spell_suggest()
end, opts)

----------------------------------------------------------------------------
-- LSP
----------------------------------------------------------------------------
keymap.set("n", "<leader>cr", function()
  require("renamer").rename({})
end, opts)

-- Description: Show line diagnostics
-- Keymap: leader + s + d
keymap.set("n", "<leader>sd", function()
  vim.diagnostic.open_float()
end, opts)

-- Description: Show hover specification
-- Keymap: shift + k => K => Upper case k
keymap.set("n", "K", function()
  vim.lsp.buf.hover()
end, opts)

-- Description: Code action
-- Keymap: leader + c + a
keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, opts)

-- Description: Rename current input
-- Keymap: leader + c + r
-- keymap.set("n", "<leader>cr", function()
--   vim.lsp.buf.rename()
-- end, opts)

-- TODO: Figure out how to make this work with function and not cmd to maintain consistency
-- Description: Show diagnostics
-- Keymap: leader + x + x
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts)

----------------------------------------------------------------------------
-- NEO TREE
----------------------------------------------------------------------------
-- Description: Toggle File explorer
-- Keymap: leader + ee
keymap.set("n", "<leader>ee", function()
  require("neo-tree.command").execute({
    toggle = true,
  })
end, opts)

-- Description: Toggle opened buffers
-- Keymap: leader + eb
keymap.set("n", "<leader>eb", function()
  require("neo-tree.command").execute({
    toggle = true,
    source = "buffers",
  })
end, opts)

-- Description: Toggle git status
-- Keymap: leader + e + g
keymap.set("n", "<leader>eg", function()
  require("neo-tree.command").execute({ toggle = true, source = "git_status" })
end, opts)

----------------------------------------------------------------------------
-- MULTICURSOR
----------------------------------------------------------------------------
keymap.set("n", "<leader>m", function()
  vim.cmd("MCstart")
end, opts)

----------------------------------------------------------------------------
-- GIT
----------------------------------------------------------------------------
keymap.set("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, opts)

keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", opts)

----------------------------------------------------------------------------
-- FOLDING
----------------------------------------------------------------------------
vim.keymap.set("n", "<leader>]", function()
  require("ufo").openAllFolds()
end, {})
vim.keymap.set("n", "<leader>[", function()
  require("ufo").closeFoldsWith()
end)

----------------------------------------------------------------------------
-- CONTEXT - treesitter
----------------------------------------------------------------------------
vim.keymap.set("n", "<leader>cc", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

-- TODO: Under construction
-- vim.keymap.set("n", "<leader>rr", function()
--   require("hedwig").run()
-- end, { noremap = true, silent = true })
