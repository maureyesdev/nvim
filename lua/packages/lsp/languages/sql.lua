local Language = require("packages.lsp.languages.language_base")

local SQLLanguage = {}
SQLLanguage.__index = SQLLanguage
setmetatable(SQLLanguage, Language)

function SQLLanguage:new()
  local obj = setmetatable(Language:new("sql"), SQLLanguage)
  obj:add_treesitter("sql")
  obj:add_formatters({ sql = "sql_formatter" })
  obj:add_lsp_installation({ "sqls", "sql-formatter", "sqlfluff" })
  return obj
end

function SQLLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("sqls", { capabilities = capabilities })
  vim.lsp.enable("sqls")
end

return SQLLanguage
