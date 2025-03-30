return {
  -----------------------------------------------------------------------------
  -- Syntax highlight
  -----------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "lua", "vim" })
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
          lua = { "stylua" },
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
      vim.list_extend(
        opts.ensure_installed,
        { "lua-language-server", "stylua" }
      )
    end,
  },

  -----------------------------------------------------------------------------
  -- LSP config
  -----------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "vim.runtime" },
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").lua_ls.setup({ capabilities = capabilities })
    end,
  },
}
