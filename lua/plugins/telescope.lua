return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),

          -- -- pseudo code / specification for writing custom displays, like the one
          -- -- for "codeactions"
          -- specific_opts = {
          --   codeactions = {
          --     -- TODO: PENDING
          --   },
          -- }
        }
      }
    })
    telescope.load_extension("ui-select")

    -- TODO: Need to move all of the below into a centralize keymap file
    -- Description: Find files in current directory
    -- Keymap: leader + p
    vim.keymap.set("n", "<leader>p", function()
      builtin.find_files(themes.get_dropdown({ previewer = false }))
    end, { noremap = true, silent = true })

    -- Description: Search input in current directory files
    -- Keymap: leader + ff
    vim.keymap.set("n", "<leader>ff", function()
      builtin.live_grep({ theme = "ivy" })
    end, { noremap = true, silent = true })

    -- Description: Search input in current file
    -- Keymap: leader + f + s
    vim.keymap.set("n", "<leader>fs", function()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown({
        previewer = false,
      }))
    end, { noremap = true, silent = true })

    -- Description: Go to definition
    -- Keymap: leader + g + d
    vim.keymap.set("n", "<leader>gd", function()
      builtin.lsp_definitions({ reuse_win = true })
    end, { noremap = true, silent = true })

    -- Description: Go to references
    -- Keymap: leader + g + r
    vim.keymap.set("n", "<leader>gr", function()
      builtin.lsp_references()
    end, { noremap = true, silent = true })

    -- Description: Go to symbol
    -- Keymap: leader + g + s
    vim.keymap.set("n", "<leader>gs", function()
      builtin.lsp_document_symbols()
    end, { noremap = true, silent = true })


    -- Description: Show hover specification
    -- Keymap: leader + k
    vim.keymap.set("n", "<leader>k", function()
    end, { noremap = true, silent = true })


    -- Description: Code action
    -- Keymap: leader + c + a
    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, { noremap = true, silent = true })

    -- Description: Rename current input
    -- Keymap: leader + c + r
    vim.keymap.set("n", "<leader>cr", function()
      vim.lsp.buf.rename()
    end, { noremap = true, silent = true })

    -- Description: Show spell suggestions
    -- Keymap: leader + s + s
    vim.keymap.set("n", "<leader>ss", function()
      builtin.spell_suggest(themes.get_cursor({}))
    end, { noremap = true, silent = true })
  end,
}
