return {
  -----------------------------------------------------------------------------
  -- Parser (syntax highlight)
  -----------------------------------------------------------------------------
  {
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = { max_lines = 3 },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      opts = {
        ensure_installed = {},
        auto_install = false,
        indent = { enable = true },
        highlight = { enable = true },
        modules = {},
        sync_install = true,
        ignore_install = {},
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
  },

  -----------------------------------------------------------------------------
  -- Formatting
  -----------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {},
      format_on_save = {
        timeout_ms = 2500,
        lsp_format = "fallback",
      },
    },
  },

  -----------------------------------------------------------------------------
  -- LSP Registry
  -----------------------------------------------------------------------------
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -----------------------------------------------------------------------------
  -- LSP ensure installation
  -----------------------------------------------------------------------------
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {},
    },
  },

  -----------------------------------------------------------------------------
  -- LSP config
  -----------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = { { "saghen/blink.cmp" } },
    opts = function()
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        virtual_text = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "single",
          header = "Diagnostic",
          prefix = "",
        },
      })
    end,
  },

  -----------------------------------------------------------------------------
  -- Utilities
  -----------------------------------------------------------------------------
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
