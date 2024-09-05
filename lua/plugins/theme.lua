return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#181825",
          },
        },
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
