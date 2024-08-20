return {
  {
    "williamboman/mason.nvim",
    config = function()
      local mason = require("mason")
      mason.setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local mason_lsp_config = require("mason-lspconfig")
      mason_lsp_config.setup({
        ensure_installed = {
          "lua_ls", -- lua
          "vtsls", -- js
          "jsonls", -- json
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.vtsls.setup({
        capabilities = capabilities,
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    requires = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formatters
          "black", -- python
          "prettier", -- js
          "stylua", -- lua
          -- Linters
          -- DAPs
        },
      })
    end,
  },
  {
    "filipdutescu/renamer.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("renamer").setup({})
    end,
  },
}
