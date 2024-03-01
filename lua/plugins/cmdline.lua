return {
  "VonHeikemen/fine-cmdline.nvim",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
  },
  config = function()
    local cmdline = require("fine-cmdline")
    cmdline.setup({})
    vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
  end,
}
