return {
  -----------------------------------------------------------------------------
  -- LSP installation
  -----------------------------------------------------------------------------
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "tailwindcss-language-server" })
    end,
  },

  -----------------------------------------------------------------------------
  -- LSP config: tailwindcss
  -----------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "sass",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          "astro",
        },
        root_dir = util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.mjs",
          "postcss.config.cjs",
          "postcss.config.ts",
          "package.json",
          "angular.json",
          "next.config.js",
          "next.config.ts",
          "next.config.mjs"
        ),
        init_options = {
          userLanguages = {
            eelixir = "html-eex",
            eruby = "erb",
            heex = "heex",
            templ = "html",
          },
        },
        settings = {
          tailwindCSS = {
            validate = true,
            emmetCompletions = true,
            classAttributes = {
              "class",
              "className",
              "class:list",
              "classList",
              "ngClass",
            },
            includeLanguages = {
              typescript = "javascript",
              typescriptreact = "javascriptreact",
            },
            experimental = {
              classRegex = {
                { "cn%(([^)]*)%)", "[\"'`]([^\"'`]*)[\"'`]" },
                { "clsx%(([^)]*)%)", "[\"'`]([^\"'`]*)[\"'`]" },
                { "cva%(([^)]*)%)", "[\"'`]([^\"'`]*)[\"'`]" },
              },
            },
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidScreen = "error",
              invalidVariant = "error",
              invalidConfigPath = "error",
              invalidTailwindDirective = "error",
              recommendedVariantOrder = "warning",
            },
          },
        },
      })
    end,
  },
}
