return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  -- optional
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },

  -- optional, highly recommended
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
}
