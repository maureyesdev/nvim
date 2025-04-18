vim.api.nvim_create_autocmd({ "BufEnter", "ModeChanged" }, {
  callback = function(args)
    local winbar_utils = require("utils.winbar")

    ---@type { old_mode: string, new_mode: string }
    local event = vim.v.event

    local old_mode = args.event == "ModeChanged" and event.old_mode or ""
    local new_mode = args.event == "ModeChanged" and event.new_mode or ""
    -- Only update if ModeChanged is relevant (e.g., leaving LazyGit)
    if args.event == "ModeChanged" then
      -- Get buffer filetype
      local buf_ft = vim.bo.filetype
      -- Only update when leaving `snacks_terminal` (LazyGit)
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
