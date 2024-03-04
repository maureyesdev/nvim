return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- {
    --   "<leader>mm",
    --   "<cmd>TroubleToggle loclist<cr>",
    --   desc = "Location List (Trouble)"
    -- },
    {
      "<leader>mm",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      desc = "Document Diagnostics (Trouble)"
    },
  },
  config = function()
    local trouble = require("trouble")
    trouble.setup({})
  end,
}
