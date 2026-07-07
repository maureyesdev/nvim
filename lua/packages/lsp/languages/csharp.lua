local Language = require("packages.lsp.languages.language_base")

local CSharpLanguage = {}
CSharpLanguage.__index = CSharpLanguage
setmetatable(CSharpLanguage, Language)

function CSharpLanguage:new()
  local obj = setmetatable(Language:new("c_sharp"), CSharpLanguage)
  obj:add_formatters({ cs = "csharpier" })
  obj:add_lsp_installation({ "roslyn-language-server", "csharpier" })
  return obj
end

function CSharpLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  require("roslyn").setup({
    config = { capabilities = capabilities },
    filewatching = "roslyn",
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
      vim.opt_local.softtabstop = 4
    end,
  })
end

return CSharpLanguage
