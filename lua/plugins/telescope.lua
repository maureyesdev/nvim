return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- require("telescope").load_extension("fzf")
		require("telescope").load_extension("lazygit")
		local t_actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = t_actions.move_selection_next,
						["<C-k>"] = t_actions.move_selection_previous,
					},
				},
			},
		})
	end,
}
