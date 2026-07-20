local Language = require("packages.lsp.languages.language_base")

local AngularLanguage = {}
AngularLanguage.__index = AngularLanguage
setmetatable(AngularLanguage, Language)

function AngularLanguage:new()
  local obj = setmetatable(Language:new("angular"), AngularLanguage)
  -- Angular components are just TypeScript + HTML under the hood; treesitter
  -- parsers and formatters are already provided by those language configs.
  obj.treesitter_parsers = {}
  obj:add_lsp_installation("angular-language-server")
  return obj
end

function AngularLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- cmd/filetypes/root_markers come from nvim-lspconfig's bundled default
  -- (lsp/angularls.lua): attaches to typescript/html files rooted at an
  -- angular.json or nx.json, probing node_modules for the project's own
  -- @angular/language-service and typescript versions.
  vim.lsp.config("angularls", {
    capabilities = capabilities,
  })
  vim.lsp.enable("angularls")
end

return AngularLanguage
