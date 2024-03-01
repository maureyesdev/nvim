return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- require("telescope").load_extension("fzf")
    require("telescope").load_extension("lazygit")
    local t_actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = t_actions.move_selection_next,
            ["<C-k>"] = t_actions.move_selection_previous,
          },
        },
      },
    })
    -- TODO: Temporary mapping. Need to configure this inside the set up instead
    local opts = { noremap = true, silent = true }
    vim.keymap.set(
      "n",
      "<leader>pp",
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>",
      opts)
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep theme=ivy<CR>", opts)
  end,
}
