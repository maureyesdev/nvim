return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    local treesitter_config = require("nvim-treesitter.configs")
    treesitter_config.setup({
      modules = {},
      ensure_installed = { "javascript", "typescript", "python", "c", "lua", "vim", "vimdoc", "query" },
      sync_install = false,
      ignore_install = {},
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = {},
      },
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
}
