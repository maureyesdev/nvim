require("config")

-- TODO: NEED TO FIND A BETTER FILE TO ADD THIS IN
-- Utility in order to highlight when copy
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Highlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
  end,
})

-- TODO: NEED TO FIND A BETTER FILE TO ADD THIS IN
-- diagnostics setup
-- Configuration for diagnostics
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(
    sign.name,
    { texthl = sign.name, text = sign.text, numhl = "" }
  )
end

local config = {
  signs = {
    active = signs, -- show signs
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    source = "always",
    header = "Diagnostic",
    prefix = "",
  },
}

vim.diagnostic.config(config)
