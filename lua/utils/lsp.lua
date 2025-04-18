local M = {}

function M.has_attached_lsp_or_formatter()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local has_real_lsp = false

  for _, client in ipairs(clients) do
    if client.name ~= "GitHub Copilot" then
      has_real_lsp = true
      break
    end
  end

  local has_formatter = false
  local ok, conform = pcall(require, "conform")
  if ok then
    local formatters = conform.list_formatters_for_buffer()
    has_formatter = not vim.tbl_isempty(formatters)
  end

  return has_real_lsp or has_formatter
end

return M
