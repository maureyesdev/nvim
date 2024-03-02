return {
  "rmagatti/goto-preview",
  config = function()
    local goto_preview = require("goto-preview")
    goto_preview.setup({})
    -- When open the preview, `one can manipulate floating windows with the regular vim
    -- window moving commands`. See `:h window-moving`
    -- C-w + H || C-w + L
    vim.keymap.set(
      "n",
      "<Leader>gpd",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      { noremap = true }
    )
  end,
}
