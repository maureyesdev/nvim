return {
  -----------------------------------------------------------------------------
  -- Syntax highlight
  -----------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(
        opts.ensure_installed,
        { "javascript", "typescript", "tsx" }
      )
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
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
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
      vim.list_extend(opts.ensure_installed, { "vtsls", "prettier" })
    end,
  },

  -----------------------------------------------------------------------------
  -- LSP config
  -----------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").vtsls.setup({ capabilities = capabilities })
    end,
  },
}
