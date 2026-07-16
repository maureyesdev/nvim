-- Show the Snacks dashboard again once no "real" buffer is left to look at,
-- e.g. after closing the last file with `d`/`bd` from the buffers picker.
local function is_empty_buf(buf)
  if vim.api.nvim_buf_get_name(buf) ~= "" or vim.bo[buf].modified then
    return false
  end
  local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or ""
  return vim.api.nvim_buf_line_count(buf) <= 1 and first_line == ""
end

local function should_show_dashboard()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.bo[buf].buftype == "" and not is_empty_buf(buf) then
      return false
    end
  end
  return true
end

-- Find a normal, non-floating window that isn't already a Snacks UI window
-- (picker, dashboard, ...). Never rely on the "current" window here: when a
-- buffer is deleted from the Snacks buffers picker, the picker's own floating
-- window is still focused, and buf/win = 0 would hijack its input buffer.
local function target_window()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_win_get_config(win).relative == "" and not vim.bo[buf].filetype:find("snacks") then
      return win, buf
    end
  end
end

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  group = vim.api.nvim_create_augroup("dashboard_on_empty", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].filetype == "snacks_dashboard" then
      return
    end
    vim.schedule(function()
      if vim.v.exiting ~= vim.NIL or not should_show_dashboard() then
        return
      end
      local win, buf = target_window()
      if win then
        Snacks.dashboard({ buf = buf, win = win })
      end
    end)
  end,
})
