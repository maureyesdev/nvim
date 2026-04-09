vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

require("nvim-treesitter").setup({
  ensure_installed = { "lua", "vim" },
  auto_install = false,
  indent = { enable = true },
  highlight = { enable = true },
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
