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
					-- LSPs
					"lua_ls", -- lua
					"vtsls", -- js
					-- DAPs
					-- Linters
					-- Formatters
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			lspconfig.vtsls.setup({
				capabilities = capabilities,
			})
		end,
	},
}
