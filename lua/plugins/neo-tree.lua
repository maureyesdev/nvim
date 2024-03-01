return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<Leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
    },
  },
  config = function()
    local neo_tree = require("neo-tree")
    local neo_tree_command = require("neo-tree.command")
    neo_tree.setup({
      window = {
        position = "right",
        width = 40,
      },
      filesystem = {
        visible = false,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignore = false,
      },
      event_handlers = {
        -- This handler is in order to close neo-tree after open a file
        {
          event = "file_opened",
          handler = function()
            neo_tree_command.execute({ action = "close" })
          end
        }
      }
    })
  end,
}
