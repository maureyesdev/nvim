return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		-- 'nvim-treesitter/nvim-treesitter-textobjects',
	},
	config = function()
		local treesitter_config = require("nvim-treesitter.configs")
		treesitter_config.setup({
			modules = {},
			ensure_installed = { "javascript", "typescript", "python", "c", "lua", "vim", "vimdoc", "query" },
			sync_install = false,
			ignore_install = {},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = {},
			},
		})
	end,
}
