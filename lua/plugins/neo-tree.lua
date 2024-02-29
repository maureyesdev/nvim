return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local neo_tree = require("neo-tree")
		neo_tree.setup({
			window = {
				position = "right",
				width = 40,
			},
			filesystem = {
				visible = false,
				show_hidden_count = true,
				hide_dotfiles = false,
				hide_gitignore = false,
			},
		})
	end,
	keys = {
		{
			"<Leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
		},
	},
}
