return {
  {
    "yorickpeterse/nvim-tree-pairs",
    config = function()
      require("tree-pairs").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        max_lines = 3,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        ensure_installed = {
          "javascript",
          "typescript",
          "python",
          "lua",
          "vim",
          "json5",
        },
        auto_install = true,
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
        },
        modules = {},
        sync_install = true,
        ignore_install = {},
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
}
