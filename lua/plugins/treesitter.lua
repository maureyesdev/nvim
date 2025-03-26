return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      ensure_installed = {},
      auto_install = true,
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      modules = {},
      sync_install = true,
      ignore_install = {},
    })
  end,
}
