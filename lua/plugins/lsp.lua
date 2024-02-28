return {
  -- Setup neovim lua configuration
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({})
    end
  },
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" } ,
      { "williamboman/mason-lspconfig.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
      { "folke/neodev.nvim" }
    },
    config = function()
      local servers = {
        clangd = {},
        pyright = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true
            }
          }
        },
        -- FOR VUE
        -- volar = {
        --   filetypes = {'vue', 'typescript', 'javascript', 'json'},
        -- },
        rust_analyzer = {},
        tsserver = {
          filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
          cmd = { "typescript-language-server", "--stdio" }
        },
        -- tailwindcss = {
        --   filetypes = {"html", "css", "scss"}
        -- },
        cssls = {
          filetypes = {"vue", "css", "scss"}
        },

        lua_ls = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }
      -- TODO: NEED TO FIGURE HOW TO RESOLVE `vim` VARIABLE TO BE VALID
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      local on_attach = function(client, _) -- (client, bufnr)
        if (client.name == "tsserver") or (client.name == "tailwindcss") then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        else
          client.server_capabilities.documentFormattingProvider = true
          client.server_capabilities.documentRangeFormattingProvider = true
        end
        -- Create a command `:Format` local to the LSP buffer
      end

      -- Setup mason so it can manage external tooling
      require('mason').setup()
      -- Ensure the servers above are installed
      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      })
    end
  },
}
