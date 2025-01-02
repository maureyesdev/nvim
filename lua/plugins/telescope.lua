return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
    {
      "isak102/telescope-git-file-history.nvim",
      dependencies = { "tpope/vim-fugitive" },
    },
  },
  config = function()
    local telescope = require("telescope")
    local gfh_actions = require("telescope").extensions.git_file_history.actions

    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--only-matching",
        },
      },
      pickers = {
        find_files = {
          theme = "ivy",
          previewer = false,
        },
        live_grep = {
          theme = "ivy",
        },
        current_buffer_fuzzy_find = {
          theme = "ivy",
          previewer = false,
        },
        lsp_references = {
          theme = "ivy",
        },
        lsp_document_symbols = {
          theme = "ivy",
        },
        lsp_definitions = {
          reuse_win = true,
        },
        spell_suggest = {
          theme = "cursor",
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        -- Documentation https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
        -- "word" -g src/path/to/file -- -g flat for folder
        -- "word" -t js -- -t flag for file type
        live_grep_args = {
          theme = "ivy",
        },
        git_file_history = {
          mappings = {
            i = {
              ["<C-g>"] = gfh_actions.open_in_browser,
            },
            n = {
              ["<C-g>"] = gfh_actions.open_in_browser,
            },
          },
          browser_command = nil,
        },
      },
    })

    telescope.load_extension("ui-select")
    telescope.load_extension("git_file_history")
    telescope.load_extension("live_grep_args")
  end,
}
