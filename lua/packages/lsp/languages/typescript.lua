local Language = require("packages.lsp.languages.language_base")

local TypeScriptLanguage = {}
TypeScriptLanguage.__index = TypeScriptLanguage
setmetatable(TypeScriptLanguage, Language)

function TypeScriptLanguage:new()
  local obj = setmetatable(Language:new("typescript"), TypeScriptLanguage)
  -- Configure treesitter languages
  obj:add_treesitter({ "javascript", "typescript", "tsx" })
  -- Configure formatters
  obj:add_formatters({
    javascript = "prettier",
    typescript = "prettier",
    javascriptreact = "prettier",
    typescriptreact = "prettier",
  })
  -- Configure mason tools
  obj:add_lsp_installation({ "vtsls", "prettier" })
  return obj
end

function TypeScriptLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("vtsls", {
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "ejs" },
    capabilities = capabilities,
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
  })
  vim.lsp.enable("vtsls")
end

return TypeScriptLanguage
