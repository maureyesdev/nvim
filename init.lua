require("config")

-- TODO: NEED TO FIND A BETTER FILE TO ADD THIS IN
-- Utility in order to highlight when copy
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
  end,
})
