local merge_opts = require("utils.merge_opts").merge_opts
local opts = {
  noremap = true, -- Prevent accidental recursive remapping
  silent = true,  -- Keep mappings quiet in the command line
}
local keymap = vim.keymap

-------------------------------------------------------------------------------
-- Leader Key & Global Setup
-------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap.set(
  { "n", "v" },
  "<Space>",
  "<Nop>",
  merge_opts({
    opts = opts,
    desc = "Disable space key to reserve as <Leader>"
  })
)

-------------------------------------------------------------------------------
-- Window Navigation & Resizing
-------------------------------------------------------------------------------

-- Navigate between windows
keymap.set(
  { "n" },
  "<C-h>",
  function() vim.cmd("wincmd h") end,
  merge_opts({ opts = opts, keys = "ctrl + h", desc = "Move to the window on the left" })
)
keymap.set(
  { "n" },
  "<C-j>",
  function() vim.cmd("wincmd j") end,
  merge_opts({ opts = opts, keys = "ctrl + j", desc = "Move to the window below" })
)
keymap.set(
  { "n" },
  "<C-k>",
  function() vim.cmd("wincmd k") end,
  merge_opts({ opts = opts, keys = "ctrl + k", desc = "Move to the window above" })
)
keymap.set(
  { "n" },
  "<C-l>",
  function() vim.cmd("wincmd l") end,
  merge_opts({ opts = opts, keys = "ctrl + l", desc = "Move to the window on the right" })
)

-- Resize windows
keymap.set(
  { "n" },
  "<C-Up>",
  function() vim.cmd("resize +20") end,
  merge_opts({ opts = opts, keys = "ctrl + up", desc = "Increase window height" })
)
keymap.set(
  { "n" },
  "<C-Down>",
  function() vim.cmd("resize -20") end,
  merge_opts({ opts = opts, keys = "ctrl + down", desc = "Decrease window height" })
)
keymap.set(
  { "n" },
  "<C-Left>",
  function() vim.cmd("vertical resize -20") end,
  merge_opts({ opts = opts, keys = "ctrl + left", desc = "Decrease window width" })
)
keymap.set(
  { "n" },
  "<C-Right>",
  function() vim.cmd("vertical resize +20") end,
  merge_opts({ opts = opts, keys = "ctrl + right", desc = "Increase window width" })
)

-- Split windows
keymap.set(
  { "n" },
  "<leader>sh",
  function() vim.cmd("split") end,
  merge_opts({ opts = opts, keys = "leader + s + h", desc = "Split window horizontally" })
)
keymap.set(
  { "n" },
  "<leader>sv",
  function() vim.cmd("vsplit") end,
  merge_opts({ opts = opts, keys = "leader + s + v", desc = "Split window vertically" })
)

-------------------------------------------------------------------------------
-- Buffer Management
-------------------------------------------------------------------------------

-- Navigate between buffers
keymap.set(
  { "n" },
  "<S-h>",
  function() vim.cmd("bprevious") end,
  merge_opts({ opts = opts, keys = "shift + h", desc = "Go to previous buffer" })
)
keymap.set(
  { "n" },
  "<S-l>",
  function() vim.cmd("bnext") end,
  merge_opts({ opts = opts, keys = "shift + l", desc = "Go to next buffer" })
)

-- Select all
keymap.set(
  { "n" },
  "<leader>aa",
  function() vim.cmd("normal! ggVG") end,
  merge_opts({ opts = opts, keys = "leader + a + a", desc = "Select entire text in buffer" })
)

-------------------------------------------------------------------------------
-- Editing & Cursor Behavior
-------------------------------------------------------------------------------

-- Increment/decrement numbers
keymap.set(
  { "n" },
  "+",
  function() vim.cmd("normal! <C-a>") end,
  merge_opts({ opts = opts, keys = "+", desc = "Increment number under cursor" })
)
keymap.set(
  { "n" },
  "-",
  function() vim.cmd("normal! <C-x>") end,
  merge_opts({ opts = opts, keys = "-", desc = "Decrement number under cursor" })
)

-------------------------------------------------------------------------------
-- Visual Mode Enhancements
-------------------------------------------------------------------------------

-- Indent and stay in visual mode
keymap.set(
  { "v" },
  "<",
  function() vim.cmd("normal! <gv") end,
  merge_opts({ opts = opts, keys = "< in visual mode", desc = "Indent left and keep selection" })
)
keymap.set(
  { "v" },
  ">",
  function() vim.cmd("normal! >gv") end,
  merge_opts({ opts = opts, keys = "> in visual mode", desc = "Indent right and keep selection" })
)

-- Paste without overwriting clipboard
keymap.set(
  { "v" },
  "p",
  '"_dP',
  merge_opts({ opts = opts, keys = "p in visual mode", desc = "Paste over without overwriting clipboard" })
)

-- Move blocks in visual block mode
keymap.set(
  { "x" },
  "J",
  ":move '>+1<CR>gv-gv",
  merge_opts({ opts = opts, keys = "J in visual block mode", desc = "Move selected block down" })
)
keymap.set(
  { "x" },
  "K",
  ":move '<-2<CR>gv-gv",
  merge_opts({ opts = opts, keys = "K in visual block mode", desc = "Move selected block up" })
)

-------------------------------------------------------------------------------
-- Plugin Keymaps (reserved)
-------------------------------------------------------------------------------

