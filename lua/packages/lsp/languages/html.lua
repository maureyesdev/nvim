local Language = require("packages.lsp.languages.language_base")

local HTMLLanguage = {}
HTMLLanguage.__index = HTMLLanguage
setmetatable(HTMLLanguage, Language)

function HTMLLanguage:new()
  local obj = setmetatable(Language:new("html"), HTMLLanguage)
  obj:add_treesitter("html")
  obj:add_formatters({ html = "prettier" })
  obj:add_lsp_installation({ "html-lsp", "prettier" })
  return obj
end

function HTMLLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("html", { capabilities = capabilities })
  vim.lsp.enable("html")
end

return HTMLLanguage
