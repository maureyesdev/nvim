return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    'nvimtools/hydra.nvim',
  },
  cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
  config = function()
    require("multicursors").setup({
      hint_config = false,
    })
  end
}
