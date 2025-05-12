local opts = { noremap = true, silent = true }

-- Remap space as leader key
local keymap = vim.keymap

-- Remap space as leader key
keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- DISABLING F1 key
vim.keymap.set({ "n", "i", "v" }, "<F1>", "<Nop>", { silent = true })
-- DISABLING default grep for snacks
vim.keymap.set({ "n" }, "<leader>gg", "<Nop>", { silent = true })

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

----------------------------------------------------------------------------
-- TERM
----------------------------------------------------------------------------

----------------------------------------------------------------------------
-- COMMAND
----------------------------------------------------------------------------

----------------------------------------------------------------------------
-- SNACKS
----------------------------------------------------------------------------
keymap.set("n", "<leader>sp", function()
  require("snacks").picker({ layout = { preset = "vscode" } })
end, opts)

keymap.set("n", "<leader>xx", function()
  require("snacks").picker.diagnostics({
    -- main means that the preview will get disabled
    layout = { preset = "ivy", preview = "main" },
  })
end, opts)

keymap.set("n", "<leader>::", function()
  require("snacks").picker.commands({ layout = { preset = "vscode" } })
end, opts)

keymap.set("n", "<leader>ee", function()
  require("snacks").picker.explorer()
end, opts)

keymap.set("n", "<leader>bb", function()
  require("snacks").picker.buffers({ layout = { preset = "vscode" } })
end, opts)

keymap.set("n", "<leader>gm", function()
  require("snacks").lazygit()
end, opts)

keymap.set("n", "<leader>gd", function()
  require("snacks").picker.git_diff({ layout = "sidebar" })
end, opts)

keymap.set("n", "<leader>gb", function()
  require("snacks").picker.git_branches({ layout = { preset = "sidebar" } })
end, opts)

keymap.set("n", "<leader>gs", function()
  require("snacks").picker.git_status({ layout = { preset = "sidebar" } })
end, opts)

-- Need to discontinue this and replace it by below keymap
keymap.set("n", "<leader>pp", function()
  require("snacks").picker.files({ layout = { preset = "vscode" } })
end, opts)

keymap.set("n", "<leader>ff", function()
  require("snacks").picker.files({ layout = { preset = "vscode" } })
end, opts)

keymap.set("n", "<leader>fg", function()
  -- require("snacks").picker.grep({ layout = { preset = "ivy" } })
  require("snacks").picker.grep({ layout = { preset = "sidebar" } })
end, opts)

-- There is a bug on this picker where:
-- -- 1. If you open the picker on dashboard, then it adds number rules
-- -- 2. if you open the picker it literally duplicates the wibar
-- keymap.set("n", "<leader>fl", function()
--   require("snacks").picker.lines({
--     layout = { preset = "vscode" },
--   })
-- end, opts)

keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, opts)

vim.keymap.set("n", "<leader>cr", function()
  local curr_name = vim.fn.expand("<cword>")
  require("snacks.input").input({
    prompt = "Rename to:",
    default = curr_name,
  }, function(new_name)
    if new_name and #new_name > 0 and new_name ~= curr_name then
      vim.lsp.buf.rename(new_name)
    end
  end)
end, { desc = "LSP: Rename with Snacks input" })

-- This behavior is the neovim default
keymap.set("n", "K", function()
  vim.lsp.buf.hover()
end, opts)

keymap.set("n", "<leader>lh", function()
  vim.lsp.buf.hover()
end, opts)

keymap.set("n", "<leader>le", function()
  vim.diagnostic.open_float()
end, opts)

keymap.set("n", "<leader>ls", function()
  require("snacks").picker.lsp_symbols({ layout = { preset = "vscode" } })
end, opts)

keymap.set("n", "<leader>lr", function()
  require("snacks").picker.lsp_references({
    -- TODO: To be defined
    -- layout = { preset = "pending" },
  })
end, opts)

keymap.set("n", "<leader>li", function()
  require("snacks").picker.lsp_implementations({
    -- TODO: To be defined
    -- layout = { preset = "pending" },
  })
end, opts)

keymap.set("n", "<leader>ld", function()
  require("snacks").picker.lsp_definitions()
end, opts)

vim.keymap.set("n", "<leader>cc", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, opts)

vim.keymap.set("n", "<localleader>ll", function()
  -- require("logsitter").log()
  require("wrapper").wrap_under_cursor()
end, opts)

vim.keymap.set("n", "<localleader>jj", function()
  require("flash").jump()
end, opts)

keymap.set("n", "<leader>cs", function()
  require("snacks").picker.spelling()
end, opts)

keymap.set("n", "<leader>dime", function()
  require("snacks").dim.enable()
end, opts)

keymap.set("n", "<leader>dims", function()
  require("snacks").dim.disable()
end, opts)

keymap.set("n", "<Esc>", function()
  if vim.v.hlsearch == 1 then
    vim.cmd("nohlsearch")
  end
end, { noremap = true, silent = true })
