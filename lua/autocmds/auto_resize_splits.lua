vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("auto_resize_splits", { clear = true }),
  callback = function()
    local current_tab = vim.api.nvim_get_current_tabpage()
    vim.cmd("tabdo wincmd =")
    vim.api.nvim_set_current_tabpage(current_tab)
  end,
})
