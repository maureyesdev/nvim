return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
          -- -- pseudo code / specification for writing custom displays, like the one
          -- -- for "codeactions"
          -- specific_opts = {
          --   codeactions = {
          --     -- TODO: PENDING
          --   },
          -- }
        }
      }
    })
    telescope.load_extension("ui-select")
    telescope.load_extension("lazygit")
  end,
}
