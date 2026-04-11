local ufo = require("ufo")

ufo.setup({
  provider_selector = function()
    return { "lsp", "indent" }
  end,
})
