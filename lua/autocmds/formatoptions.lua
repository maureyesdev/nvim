-- Filetype plugins tend to re-add these comment-continuation flags, so strip
-- them on every FileType event rather than once at startup.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment_continuation", { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
