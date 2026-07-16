local M = {}

local workspace_root = vim.fn.getcwd()

local function get_buffer_count()
  return vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
end

local function get_winbar_path()
  local full_path = vim.fn.expand("%:p:h")

  if full_path:find(workspace_root, 1, true) == 1 then
    local relative_path = full_path:sub(#workspace_root + 2)
    if relative_path == "" then
      return "󰉋 . "
    end
    return "󰉋 " .. relative_path .. " "
  end

  return full_path:gsub(vim.fn.expand("$HOME"), "~")
end

-- Neovim keeps a window-local 'winbar' set to "" visually enabled (an empty
-- but rendered bar) once it has been assigned a value, even if that value is
-- empty. `setlocal winbar<` is the only way to fully drop back to "no bar".
function M.clear(winid)
  winid = winid or vim.api.nvim_get_current_win()
  pcall(vim.api.nvim_win_call, winid, function()
    vim.cmd("setlocal winbar<")
  end)
end

function M.update()
  local winid = vim.api.nvim_get_current_win()
  -- Skip floating
  local config = vim.api.nvim_win_get_config(winid)
  if config.relative ~= "" then
    return
  end

  local bufnr = vim.api.nvim_win_get_buf(winid)
  if vim.bo[bufnr].filetype == "snacks_dashboard" then
    M.clear(winid)
    return
  end

  local winbar = M.build()

  pcall(function()
    vim.wo[winid].winbar = winbar
  end)
end

function M.build()
  local file_path = get_winbar_path()
  local buffer_count = get_buffer_count()
  local file_name = vim.fn.expand("%:t")

  return table.concat({
    "%#WinbarBufferCount# (" .. buffer_count .. ") ",
    "%#WinbarFileName#%m " .. file_name,
    "%*%=%#WinbarFilePath# " .. file_path,
  })
end

return M
