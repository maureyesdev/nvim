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
            _nc = "#16141f",
            base = "#000000",
            surface = "#000000",
            overlay = "#000000",
            muted = "#6e6a86",
            subtle = "#908caa",
            text = "#e0def4",
            love = "#eb6f92",
            gold = "#f6c177",
            rose = "#ebbcba",
            pine = "#31748f",
            foam = "#9ccfd8",
            iris = "#c4a7e7",
            leaf = "#95b1ac",
            highlight_low = "#21202e",
            highlight_med = "#403d52",
            highlight_high = "#524f67",
            none = "NONE",
          },
        },
        highlight_groups = {
          IblIndent = { fg = "#26233a" },
          ColorColumn = { bg = "#1f1d2e" },
          Folded = { bg = "#1f1d2e" },
          NormalFloat = { bg = "#191724" },
          TelescopeNormal = { bg = "#000000" },
          TelescopeTitle = { bg = "#191724", fg = "#ebbcba" },
          TelescopeSelection = { bg = "#191724" },
          MiniIndentscopeSymbol = { bg = "None", fg = "#ebbcba" },
          CursorLine = { bg = "#191724" },
        },
      })

      vim.cmd.colorscheme("rose-pine")
    end,
  },
}
