local mason = require("mason")
local mason_tool_installer = require("mason-tool-installer")
local lazydev = require("lazydev")

mason.setup()
mason_tool_installer.setup({
  ensure_installed = { "lua-language-server", "stylua" },
})

lazydev.setup({
  library = {
    { path = "vim.runtime" },
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {})
