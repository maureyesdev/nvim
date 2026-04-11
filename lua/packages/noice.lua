local noice = require("noice")

noice.setup({
  lsp = {
    -- HACK: this should not be the place to configure this
    hover = {
      enabled = true,
      opts = { border = "single" },
    },
    -- HACK: this should not be the place to configure this
    signature = {
      enabled = true,
      opts = { border = "single" },
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
})
