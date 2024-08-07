return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local neo_tree = require("neo-tree")
    local neo_tree_command = require("neo-tree.command")
    neo_tree.setup({
      window = {
        -- position = "right",
        position = "float",
      },
      event_handlers = {
        -- TODO: Need to find a better place to put his
        -- This handler is in order to close neo-tree after open a file
        {
          event = "file_opened",
          handler = function()
            neo_tree_command.execute({ action = "close" })
          end,
        },
      },
    })
  end,
}
