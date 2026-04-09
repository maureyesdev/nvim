vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/folke/lazydev.nvim",
})

require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = { "lua-language-server", "stylua" },
})

require("lazydev").setup({
  library = {
    { path = "vim.runtime" },
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {})
