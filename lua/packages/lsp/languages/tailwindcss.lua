local Language = require("packages.lsp.languages.language_base")

local TailwindLanguage = {}
TailwindLanguage.__index = TailwindLanguage
setmetatable(TailwindLanguage, Language)

function TailwindLanguage:new()
  local obj = setmetatable(Language:new("tailwindcss"), TailwindLanguage)
  obj.treesitter_parsers = {}
  obj.formatters = {}
  obj:add_lsp_installation({ "tailwindcss-language-server" })
  return obj
end

function TailwindLanguage:setup_lsp()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("tailwindcss", {
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
    root_markers = {
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
      "next.config.mjs",
    },
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
  vim.lsp.enable("tailwindcss")
end

return TailwindLanguage
