vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("custom_yank_highlight", {}),
  callback = function()
    vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#908caa", fg = "#000000" })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Highlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 80 })
  end,
})
