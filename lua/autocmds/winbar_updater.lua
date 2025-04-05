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

local function shorten_path(path)
  local segments = vim.split(path, "/")
  local shortened = {}

  for i = 1, #segments do
    local segment = segments[i]
    if i == 1 then
      table.insert(shortened, segment) -- ~ or empty root
    elseif i == #segments then
      table.insert(shortened, segment) -- keep final dir/file
    elseif #segment > 0 then
      table.insert(shortened, segment:sub(1, 1)) -- collapse to first char
    end
  end

  return table.concat(shortened, "/")
end

local function update_winbar()
  local winid = vim.api.nvim_get_current_win()

  -- Skip floating
  local config = vim.api.nvim_win_get_config(winid)
  if config.relative ~= "" then
    return
  end

  local file_path = get_winbar_path()
  local short_path = shorten_path(file_path)
  local buffer_count = get_buffer_count()
  local file_name = vim.fn.expand("%:t")

  local full = table.concat({
    "%#BufferCount#(" .. buffer_count .. ") ",
    "%#FileName#%m " .. file_name,
    "%*%=%#FilePath# " .. file_path,
  })

  local short = table.concat({
    "%#BufferCount#(" .. buffer_count .. ") ",
    "%#FileName#%m " .. file_name,
    "%*%=%#FilePath# " .. short_path,
  })

  local win_width = vim.api.nvim_win_get_width(winid)
  local winbar = vim.fn.strdisplaywidth(full) > win_width and short or full

  pcall(function()
    vim.wo[winid].winbar = winbar
  end)
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
