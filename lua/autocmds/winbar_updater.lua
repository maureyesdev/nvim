local color_surface = "#0f0d1a"
local color_gold = "#f6c177"
local color_pine = "#31748f"
local color_foam = "#9ccfd8"

-- Move this to theme config instead
vim.api.nvim_set_hl(
  0,
  "BufferCount",
  { bg = color_surface, fg = color_pine, bold = false }
)

vim.api.nvim_set_hl(
  0,
  "FileName",
  { bg = color_surface, fg = color_foam, bold = false }
)

vim.api.nvim_set_hl(
  0,
  "FilePath",
  { bg = color_surface, fg = color_gold, bold = false }
)

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
