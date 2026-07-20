local Language = require("packages.lsp.languages.language_base")

local PrismaLanguage = {}
PrismaLanguage.__index = PrismaLanguage
setmetatable(PrismaLanguage, Language)

function PrismaLanguage:new()
  local obj = setmetatable(Language:new("prisma"), PrismaLanguage)
  obj:add_treesitter("prisma")
  -- prisma-language-server implements textDocument/formatting itself, so
  -- formatting goes through the LSP fallback instead of a conform formatter.
  obj:add_lsp_installation("prisma-language-server")
  return obj
end

function PrismaLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("prismals", { capabilities = capabilities })
  vim.lsp.enable("prismals")
end

return PrismaLanguage
