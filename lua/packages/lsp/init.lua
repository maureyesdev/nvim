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
    formatters = {
      prettier = {
        prepend_args = { "--single-quote" },
      },
    },
    format_on_save = {
      timeout_ms = 2500,
      lsp_format = "fallback",
    },
  })

  -------------------------------------------------------------------------------
  -- Linting
  -------------------------------------------------------------------------------
  local lint = require("lint")
  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

  lint.linters.sqlfluff = vim.tbl_deep_extend("force", lint.linters.sqlfluff, {
    cmd = mason_bin .. "/sqlfluff",
    args = { "lint", "--dialect", "postgres", "--exclude-rules", "layout", "--format", "json" },
  })

  lint.linters_by_ft = {
    sql = { "sqlfluff" },
  }

  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    callback = function()
      lint.try_lint()
    end,
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

  -------------------------------------------------------------------------------
  -- User commands
  -------------------------------------------------------------------------------
  vim.api.nvim_create_user_command("LspInfo", function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
      vim.notify("No LSP clients attached to this buffer", vim.log.levels.WARN)
      return
    end
    for _, client in ipairs(clients) do
      local root = client.config.root_dir or "(none)"
      vim.notify(
        string.format(
          "• %s  (id=%d)\n  root: %s",
          client.name,
          client.id,
          root
        ),
        vim.log.levels.INFO
      )
    end
  end, { desc = "Show LSP clients attached to current buffer" })

  vim.api.nvim_create_user_command("LspRestart", function(opts)
    local bufnr = 0
    local targets = {}
    if opts.args ~= "" then
      for _, client in ipairs(vim.lsp.get_clients()) do
        if client.name == opts.args then
          table.insert(targets, client)
        end
      end
    else
      targets = vim.lsp.get_clients({ bufnr = bufnr })
    end
    if #targets == 0 then
      vim.notify("No matching LSP clients", vim.log.levels.WARN)
      return
    end
    local names = {}
    for _, client in ipairs(targets) do
      table.insert(names, client.name)
      client:stop()
    end
    vim.defer_fn(function()
      for _, name in ipairs(names) do
        vim.lsp.enable(name)
      end
      vim.cmd("edit")
      vim.notify(
        "Restarted: " .. table.concat(names, ", "),
        vim.log.levels.INFO
      )
    end, 500)
  end, {
    nargs = "?",
    desc = "Restart LSP clients (all attached, or by name)",
    complete = function()
      local names = {}
      for _, client in ipairs(vim.lsp.get_clients()) do
        table.insert(names, client.name)
      end
      return names
    end,
  })

  -------------------------------------------------------------------------------
  -- Diagnostic
  -------------------------------------------------------------------------------
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
end

-- Register languages
M.register_language(require("packages.lsp.languages.lua"))
M.register_language(require("packages.lsp.languages.typescript"))
M.register_language(require("packages.lsp.languages.angular"))
M.register_language(require("packages.lsp.languages.html"))
M.register_language(require("packages.lsp.languages.css"))
M.register_language(require("packages.lsp.languages.tailwindcss"))
M.register_language(require("packages.lsp.languages.csharp"))
M.register_language(require("packages.lsp.languages.ejs"))
M.register_language(require("packages.lsp.languages.deno"))
M.register_language(require("packages.lsp.languages.sql"))
M.register_language(require("packages.lsp.languages.json"))
M.register_language(require("packages.lsp.languages.yaml"))
M.register_language(require("packages.lsp.languages.prisma"))

-- Initialize everything
M.setup()

return M
