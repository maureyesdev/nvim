return {
  -----------------------------------------------------------------------------
  -- Syntax highlight
  -----------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "json5" })
    end,
  },

  -----------------------------------------------------------------------------
  -- Formatting
  -----------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft =
        vim.tbl_deep_extend("force", opts.formatters_by_ft, {
          json = { "prettier" },
        })
    end,
  },

  -----------------------------------------------------------------------------
  -- LSP installation
  -----------------------------------------------------------------------------
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "json-lsp" })
    end,
  },

  -----------------------------------------------------------------------------
  -- LSP config
  -----------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/SchemaStore.nvim" },
    opts = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").jsonls.setup({
        capabilities = capabilities,
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas
            or {}
          vim.list_extend(
            new_config.settings.json.schemas,
            require("schemastore").json.schemas()
          )
        end,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
          },
        },
      })
    end,
  },
}
