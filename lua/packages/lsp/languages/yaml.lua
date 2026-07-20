local Language = require("packages.lsp.languages.language_base")

local YAMLLanguage = {}
YAMLLanguage.__index = YAMLLanguage
setmetatable(YAMLLanguage, Language)

function YAMLLanguage:new()
  local obj = setmetatable(Language:new("yaml"), YAMLLanguage)
  obj:add_treesitter("yaml")
  obj:add_formatters({ yaml = "prettier" })
  obj:add_lsp_installation({ "yaml-language-server", "prettier" })
  return obj
end

function YAMLLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("yamlls", { capabilities = capabilities })
  vim.lsp.enable("yamlls")
end

return YAMLLanguage
