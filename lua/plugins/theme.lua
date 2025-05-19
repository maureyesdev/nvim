return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
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
          base = "#191724",
          surface = "#1f1d2e",
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
        moon = {
          _nc = "#16141f",
          -- 6 tones down
          base = "#0f0e18",
          surface = "#141221",
          -- 8 tones down
          -- base = "#0a0911",
          -- surface = "#0f0d1a",
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
        dawn = {
          _nc = "#f8f0e7",
          base = "#faf4ed",
          surface = "#fffaf3",
          overlay = "#f2e9e1",
          muted = "#9893a5",
          subtle = "#797593",
          text = "#464261",
          love = "#b4637a",
          gold = "#ea9d34",
          rose = "#d7827e",
          pine = "#286983",
          foam = "#56949f",
          iris = "#907aa9",
          leaf = "#6d8f89",
          highlight_low = "#f4ede8",
          highlight_med = "#dfdad9",
          highlight_high = "#cecacd",
          none = "NONE",
        },
      },

      highlight_groups = {
        -- SnacksIndentScope = { fg = "rose" },
        -- TreesitterContextLineNumber = { fg = "pine", bg = "base" },
        -- TreesitterContext = { bg = "base" },
        -- CursorLine = { bg = "surface" },
        -- CursorLineNr = { fg = "rose" },
        -- Winbar highlight groups
        WinbarBufferCount = { bg = "surface", fg = "pine" },
        WinbarFileName = { bg = "surface", fg = "foam" },
        WinbarFilePath = { bg = "surface", fg = "gold" },
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
    },
    -- config = function(_, opts)
    --   require("rose-pine").setup(opts)
    --   vim.cmd("colorscheme rose-pine")
    -- end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "auto", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
