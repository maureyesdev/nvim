local Language = require("packages.lsp.languages.language_base")

local DenoLanguage = {}
DenoLanguage.__index = DenoLanguage
setmetatable(DenoLanguage, Language)

function DenoLanguage:new()
  local obj = setmetatable(Language:new("deno"), DenoLanguage)
  -- Treesitter parsers already provided by the TypeScript language config
  -- denols ships with the Deno CLI — no mason install needed
  return obj
end

function DenoLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("denols", {
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    capabilities = capabilities,
    root_markers = { "deno.json", "deno.jsonc" },
    settings = {
      deno = {
        enable = true,
        suggest = {
          imports = {
            hosts = { ["https://deno.land"] = true },
          },
        },
      },
    },
  })
  vim.lsp.enable("denols")
end

return DenoLanguage
