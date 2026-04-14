local Language = require("packages.lsp.languages.language_base")
local lazydev = require("lazydev")

local LuaLanguage = {}
LuaLanguage.__index = LuaLanguage
setmetatable(LuaLanguage, Language)

function LuaLanguage:new()
  local obj = setmetatable(Language:new("lua"), LuaLanguage)
  obj:add_treesitter({ "lua", "vim" })
  obj:add_formatters({ lua = "stylua" })
  obj:add_lsp_installation({ "lua-language-server", "stylua" })
  return obj
end

function LuaLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  lazydev.setup({
    library = {
      { path = "vim.runtime" },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  })

  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  })
  vim.lsp.enable("lua_ls")
end

return LuaLanguage
