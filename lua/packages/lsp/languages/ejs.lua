local Language = require("packages.lsp.languages.language_base")

local EJSLanguage = {}
EJSLanguage.__index = EJSLanguage
setmetatable(EJSLanguage, Language)

function EJSLanguage:new()
  local obj = setmetatable(Language:new("ejs"), EJSLanguage)
  -- EJS is parsed by the `embedded_template` grammar (shared with ERB), which
  -- injects the html + javascript regions found inside a template.
  obj.treesitter_parsers = { "embedded_template", "html", "javascript" }
  -- The html + js portions are served by html-lsp and vtsls, both of which
  -- already list `ejs` in their filetypes (see html.lua / typescript.lua).
  -- Formatting goes through prettier (requires the `prettier-plugin-ejs`
  -- package to be resolvable from the project / global node_modules).
  obj:add_formatters({ ejs = "prettier" })
  obj:add_lsp_installation({ "prettier" })
  return obj
end

function EJSLanguage:setup_lsp()
  -- Detect *.ejs files as the `ejs` filetype so the html/vtsls servers attach.
  vim.filetype.add({
    extension = { ejs = "ejs" },
  })

  -- Map the `ejs` filetype to the embedded_template parser and turn on
  -- treesitter highlighting for those buffers.
  vim.treesitter.language.register("embedded_template", "ejs")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ejs",
    callback = function(args)
      pcall(vim.treesitter.start, args.buf, "embedded_template")
    end,
  })
end

return EJSLanguage
