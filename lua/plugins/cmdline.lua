return {
	"VonHeikemen/fine-cmdline.nvim",
	dependencies = {
		{ "MunifTanjim/nui.nvim" },
	},
	config = function()
		local cmdline = require("fine-cmdline")
		cmdline.setup({})
	end,
}
