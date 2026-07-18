local ufo = require("ufo")

ufo.setup({
  provider_selector = function(_, filetype)
    if filetype == "ejs" then
      return { "indent" }
    end
    return { "lsp", "indent" }
  end,
})
