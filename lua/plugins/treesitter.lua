return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    treesitter_config = require("nvim-treesitter.configs")
    treesitter_config.setup({})
  end,
}
