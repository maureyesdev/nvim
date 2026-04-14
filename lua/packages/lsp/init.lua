-- All of this, should be going to the utils folder
local M = {}

-- Collect all language configurations
M.languages = {}

-- Register a language configuration
function M.register_language(lang_module)
  local lang = lang_module:new()
  table.insert(M.languages, lang)
end

-- Setup all languages
function M.setup()
  -- Collect configurations from all registered languages
  local treesitter_parsers = {}
  local formatters = {}
  local lsp_installation = {}

  for _, lang in ipairs(M.languages) do
    -- Collect treesitter parser languages
    for _, parser in ipairs(lang.treesitter_parsers) do
      table.insert(treesitter_parsers, parser)
    end

    -- Collect formatters
    for ft, _formatters in pairs(lang.formatters) do
      formatters[ft] = _formatters
    end

    -- Collect lsp installations
    for _, tool in ipairs(lang.mason_tools) do
      table.insert(lsp_installation, tool)
    end

    -- Setup LSP for this language
    lang:setup_lsp()
  end

  -- Remove duplicates from treesitter parser languages
  treesitter_parsers =
    vim.tbl_keys(vim.iter(treesitter_parsers):fold({}, function(acc, lang)
      acc[lang] = true
      return acc
    end))

  -------------------------------------------------------------------------------
  -- Parser (syntax highlight)
  -------------------------------------------------------------------------------
  require("nvim-treesitter").setup({
    ensure_installed = treesitter_parsers,
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
  })

  -------------------------------------------------------------------------------
  -- Formatting
  -------------------------------------------------------------------------------
  require("conform").setup({
    formatters_by_ft = formatters,
    format_on_save = {
      timeout_ms = 2500,
      lsp_format = "fallback",
    },
  })

  -------------------------------------------------------------------------------
  -- LSP Registry
  -------------------------------------------------------------------------------
  require("mason").setup({})

  -------------------------------------------------------------------------------
  -- LSP Installation
  -------------------------------------------------------------------------------
  require("mason-tool-installer").setup({
    ensure_installed = lsp_installation,
  })
end

-- Register languages
M.register_language(require("packages.lsp.languages.lua"))
M.register_language(require("packages.lsp.languages.typescript"))
M.register_language(require("packages.lsp.languages.html"))
M.register_language(require("packages.lsp.languages.css"))

-- Initialize everything
M.setup()

return M
