return {
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha",
  --       color_overrides = {
  --         mocha = {
  --           base = "#000000",
  --           mantle = "#000000",
  --         },
  --       },
  --     })
  --
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "main",
        dark_variant = "main",
        palette = {
          main = {
            base = "#000000",
            surface = "#000000",
            -- overlay = "#191724",
            overlay = "#000000",
          },
        },
      })

      vim.cmd.colorscheme("rose-pine")

      local set_hl = vim.api.nvim_set_hl
      set_hl(0, "IblIndent", { fg = "#191724" })
      set_hl(0, "ColorColumn", { bg = "#191724" })
      set_hl(0, "Folded", { bg = "#191724" })
      set_hl(0, "NormalFloat", { bg = "#191724" })
      set_hl(0, "TelescopeNormal", { bg = "#000000" })
      set_hl(0, "TelescopeTitle", { bg = "#191724", fg = "#ebbcba" })
      set_hl(0, "TelescopeSelection", { bg = "#191724" })
      set_hl(0, "MiniIndentscopeSymbol", { bg = "None", fg = "#ebbcba" })
      set_hl(0, "CursorLine", { bg = "#191724" })
    end,
  },
}
