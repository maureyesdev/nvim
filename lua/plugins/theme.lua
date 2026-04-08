vim.pack.add({
  { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
})

require("rose-pine").setup({
  variant = "main",
  dark_variant = "main",
  dim_inactive_windows = false,
  extend_background_behind_borders = true,
  enable = {
    terminal = true,
    legacy_highlights = true,
    migrations = true,
  },
  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },
  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",
    error = "love",
    hint = "iris",
    info = "foam",
    note = "pine",
    todo = "rose",
    warn = "gold",
    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",
    h1 = "iris",
    h2 = "foam",
    h3 = "rose",
    h4 = "gold",
    h5 = "pine",
    h6 = "foam",
  },
  palette = {
    main = {
      _nc = "#16141f",
      base = "#090B10",
      surface = "#090B10",
      overlay = "#26233a",
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
    TreesitterContextLineNumber = { fg = "pine", bg = "base" },
    TreesitterContext = { bg = "base" },
    ColorColumn = { bg = "overlay" },
    CursorLine = { bg = "base" },
    CursorLineNr = { fg = "rose" },

    -- Winbar highlight groups
    WinbarBufferCount = { bg = "surface", fg = "pine" },
    WinbarFileName = { bg = "surface", fg = "foam" },
    WinbarFilePath = { bg = "surface", fg = "gold" },
    FloatBorder = { fg = "foam" },
    -- NormalFloat = { bg = "foam" },
  },

  ---@diagnostic disable: unused-local
  before_highlight = function(group, highlight, palette)
    -- Disable all undercurls
    -- if highlight.undercurl then
    --     highlight.undercurl = false
    -- end
    --
    -- Change palette colour
    -- if highlight.fg == palette.pine then
    --     highlight.fg = palette.foam
    -- end
  end,
})
