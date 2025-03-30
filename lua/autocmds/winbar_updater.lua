-- TODO: NEED TO GET BACK TO THIS FILE TO REFACTOR
-- getting the
local color_surface = "#0f0d1a"
local color_gold = "#f6c177"
local color_pine = "#31748f"
local color_foam = "#9ccfd8"

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

-- Function to get the full path and replace the home directory with ~
local function get_winbar_path()
  local full_path = vim.fn.expand("%:p:h")
  return full_path:gsub(vim.fn.expand("$HOME"), "~")
end
-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
  return vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
end

local function update_winbar()
  local home_replaced = get_winbar_path()
  local buffer_count = get_buffer_count()
  vim.opt.winbar = table.concat({
    "%#BufferCount#(" .. buffer_count .. ") ",
    "%#FileName#%m " .. vim.fn.expand("%:t"),
    "%*%=%#FilePath# " .. home_replaced,
  })
end

vim.api.nvim_create_autocmd({ "BufEnter", "ModeChanged" }, {
  callback = function(args)
    local old_mode = args.event == "ModeChanged" and vim.v.event.old_mode or ""
    local new_mode = args.event == "ModeChanged" and vim.v.event.new_mode or ""
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
        update_winbar()
      end
    else
      update_winbar()
    end
  end,
})
