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
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "j-hui/fidget.nvim" },
      { "folke/neodev.nvim" }
    },
    keys = {
      {
        "<Leader>lsp",
        "<cmd>LspInfo<CR>",
        desc = "Lsp info"
      },
      {
        "<Leader>gd",
        function()
          require("telescope.builtin").lsp_definitions({ reuse_win = true })
        end,
        desc = "Goto Definition",
      },
      {
        "<Leader>gr",
        "<cmd>Telescope lsp_references<cr>",
        desc = "References"
      },
      -- {
      --   "<Leader>gD",
      --   vim.lsp.buf.declaration,
      --   desc = "Goto Declaration"
      -- },
      -- {
      --   "<Leader>gI",
      --   function()
      --     require("telescope.builtin").lsp_implementations({ reuse_win = true })
      --   end,
      --   desc = "Goto Implementation"
      -- },
      {
        "<Leader>k",
        vim.lsp.buf.hover,
        desc = "Hover"
      },
      -- {
      --   "<Leader>gk",
      --   vim.lsp.buf.signature_help,
      --   desc = "Signature Help",
      -- },
      -- {
      --   "<c-k>",
      --   vim.lsp.buf.signature_help,
      --   mode = "i",
      --   desc = "Signature Help",
      -- },
      -- TODO: NEED TO FIGURE OUT TO PUT THIS IN A MORE ELEGANT WAY
      {
        "<leader>ca",
        vim.lsp.buf.code_action,
        desc = "Code Action",
        mode = { "n", "v" },
      },
      -- Organize imports, sort imports, remove unused imports, add missing imports
      {
        "<leader>cA",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
        desc = "Source Action",
      },
      -- TODO: NEED TO FIGURE OUT TO PUT THIS IN A MORE ELEGANT WAY
      {
        "<leader>cr",
        vim.lsp.buf.rename,
        desc = "Rename",
      },
      {
        "<leader>gs",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Goto Symbol",
      },
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
          filetypes = { "vue", "css", "scss" }
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
