local tabline = {
  "tamton-aquib/staline.nvim",
  config = function()
    require("stabline").setup({
      style = "bar", -- others: arrow, slant, bubble
      stab_left = " ",
      stab_right = " ",

      -- fg       = Default is fg of "Normal".
      -- bg       = Default is bg of "Normal".
      -- ? Should this colors be inverted?
      inactive_bg = "#26233a",
      inactive_fg = "#aaaaaa",
      -- stab_bg  = Default is darker version of bg.,

      font_active = "bold",
      exclude_fts = { "NvimTree", "dashboard", "lir" },
      stab_start = "", -- The starting of stabline
      stab_end = "",
      -- numbers     = function(bufn, n)
      --   return '*' .. n .. ' '
      -- end
    })
  end,
}

return tabline
