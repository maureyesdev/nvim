return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  config = function()
    local barbecue = require("barbecue")
    barbecue.setup({
      -- TODO: This does not work and need to figure out a way to exclude the terminal
      exclude_filetypes = {
        "netrw",
        "toggleterm"
      },
      symbols = {},
      kinds = {},
    })
  end
}
