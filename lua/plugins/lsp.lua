return {
	{
		"williamboman/mason.nvim",
		config = function()
			local mason = require("mason")
			mason.setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local mason_lsp_config = require("mason-lspconfig")
			mason_lsp_config.setup({
				ensure_installed = {
					"lua_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = {
                "vim"
              },
            },
            workspace = {
              checkThirdParty = false
            },
            telemetry = {
              enable = false
            },
          },
        },
			})
			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			-- vim.keymap.set("n", ".", vim.lsp.buf.code_action, {})
		end,
	},
}

