-- The dashboard buffer is set up in-place (no BufEnter fires for it), and
-- Snacks itself sets a local, empty `winbar` on its window, which Neovim
-- still renders as a blank bar. Clear it the moment the filetype lands.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_dashboard",
  callback = function()
    require("utils.winbar").clear()
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "ModeChanged" }, {
  callback = function(args)
    local winbar_utils = require("utils.winbar")

    ---@type { old_mode: string, new_mode: string }
    local event = vim.v.event

    local old_mode = args.event == "ModeChanged" and event.old_mode or ""
    local new_mode = args.event == "ModeChanged" and event.new_mode or ""
    -- Only update if ModeChanged is relevant
    if args.event == "ModeChanged" then
      -- Get buffer filetype
      local buf_ft = vim.bo.filetype
      -- Only update when leaving terminal mode
      if
        buf_ft == "snacks_terminal"
        or old_mode:match("^t")
        or new_mode:match("^n")
      then
        winbar_utils.update()
      end
    else
      winbar_utils.update()
    end
  end,
})
