return {
  "gaelph/logsitter.nvim",
  enabled = false,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local logsitter = require("logsitter")

    logsitter.setup({
      path_format = "fileonly",
      prefix = "🚀 ~ ",
      separator = "",
    })
  end,
}
