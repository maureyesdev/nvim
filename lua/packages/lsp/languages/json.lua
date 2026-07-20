local Language = require("packages.lsp.languages.language_base")

local JSONLanguage = {}
JSONLanguage.__index = JSONLanguage
setmetatable(JSONLanguage, Language)

function JSONLanguage:new()
  local obj = setmetatable(Language:new("json"), JSONLanguage)
  obj:add_treesitter("json")
  obj:add_formatters({ json = "prettier", jsonc = "prettier" })
  obj:add_lsp_installation({ "json-lsp", "prettier" })
  return obj
end

function JSONLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("jsonls", { capabilities = capabilities })
  vim.lsp.enable("jsonls")
end

return JSONLanguage
