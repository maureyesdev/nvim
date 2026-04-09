vim.pack.add({
  "https://github.com/saghen/blink.cmp",
  "https://github.com/rafamadriz/friendly-snippets",
})

require("blink.cmp").setup({
  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = { force_version = "v1.9.1" },
  },

  keymap = {
    preset = "default",
    ["<cr>"] = { "select_and_accept", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide" },
    ["<C-y>"] = { "select_and_accept" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },
    ["<c-f>"] = { "scroll_documentation_up", "fallback" },
    ["<c-b>"] = { "scroll_documentation_down", "fallback" },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  cmdline = {
    enabled = false,
    keymap = {
      ["<Tab>"] = { "show_and_insert", "accept" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-y>"] = { "select_and_accept" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },
    },
  },

  completion = {
    menu = {
      auto_show = true,
      draw = {
        gap = 1,
        padding = 2,
      },
    },
    accept = {
      auto_brackets = {
        enabled = false,
      },
    },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
