return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
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

        -- 6 tones down
        -- base = "#0f0e18",
        -- surface = "#141221",

        -- 8 tones down
        base = "#0a0911",
        surface = "#0f0d1a",

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

    -- TODO: Need to add comments for each highlight group to explain
    highlight_groups = {
      SnacksIndentScope = { fg = "rose" },
      TreesitterContextLineNumber = { fg = "pine", bg = "base" },
      TreesitterContext = { bg = "base" },
      CursorLine = { bg = "surface" },
      CursorLineNr = { fg = "rose" },
    },

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
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd("colorscheme rose-pine")
  end,
}
