local Language = require("packages.lsp.languages.language_base")

local CSSLanguage = {}
CSSLanguage.__index = CSSLanguage
setmetatable(CSSLanguage, Language)

function CSSLanguage:new()
  local obj = setmetatable(Language:new("css"), CSSLanguage)
  obj:add_treesitter("css")
  obj:add_formatters({ css = "prettier" })
  obj:add_lsp_installation({ "css-lsp", "prettier" })
  return obj
end

function CSSLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("cssls", { capabilities = capabilities })
  vim.lsp.enable("cssls")
end

return CSSLanguage
