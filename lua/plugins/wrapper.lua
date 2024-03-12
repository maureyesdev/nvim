return {
  "yuki-uthman/wrapper.nvim",
  config = function()
    local wrapper = require("wrapper")
    wrapper.setup({
      lua = "print({})",
      javascript = "console.log('🚀 ~ {}', {})",
      typescript = "console.log('🚀 ~ {}', {})",
    })

    -- vim.keymap.set("n", "<Leader>ll", wrapper.wrap_under_cursor)
  end
}
