return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
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
      keymap = {
        ["<Tab>"] = { "show_and_insert", "accept" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      },
      completion = {
        menu = {
          auto_show = false,
          draw = {
            columns = {
              { "label" },
            },
          },
        },
      },
    },
    completion = {
      menu = {
        auto_show = true,
        border = "rounded",
        draw = {
          gap = 1,
          padding = 2,
          columns = {
            -- { "kind_icon" },
            { "label" },
            { "kind" },
          },
          components = {
            label = {
              text = function(ctx)
                -- this removes from the label the parenthesis
                -- example
                -- transform  this `nvim__complete_set(index, opts)`
                -- to this `nvim__complete_set`
                return ctx.label:match("^[^(]+")
              end,
            },
          },
        },
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      documentation = { auto_show = false },
      list = {
        selection = {
          preselect = false,
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
