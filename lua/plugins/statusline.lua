return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lsp_utils = require("utils.lsp")

    require("lualine").setup({
      options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(mode)
              return mode:lower()
            end,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            -- render if not in tmux session.
            cond = function()
              return vim.env.TMUX == nil
            end,
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = {
              error = " ",
              warn = " ",
              hint = " ",
              info = " ",
            },
            colored = true,
            update_in_insert = false,
            always_visible = true,
            cond = lsp_utils.has_attached_lsp_or_formatter,
            fmt = function(str)
              local out = {}
              for hl, icon, count in string.gmatch(str, "(%%#.-#)(.-)(%d+)") do
                if tonumber(count) > 0 then
                  table.insert(out, hl .. icon .. count)
                end
              end
              -- fallback to default if no hl group
              -- if #out == 0 then
              --   return "✔ clean"
              -- end
              return table.concat(out, " ")
            end,
          },
        },
        lualine_c = {
          {
            "diff",
            symbols = {
              -- symbols = {
              -- added = " ",
              -- modified = " ",
              -- removed = " ",
              added = " ",
              modified = " ",
              removed = " ",
              -- added = "+ ",
              -- modified = "~ ",
              -- removed = "- ",
            },
          },
        },
        lualine_x = {
          {
            "location",
            icon = "",
          },
          {
            "progress",
          },
          {
            "filetype",
            fmt = string.lower,
            icons_enabled = true,
          },
        },
        lualine_y = {},
        lualine_z = {
          {
            function()
              local lsp = " "
              local buf_ft = vim.bo.filetype
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              local lsp_names = {}

              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes or {}
                if vim.tbl_contains(filetypes, buf_ft) then
                  if client.name ~= "null-ls" then -- skip null-ls if using conform
                    table.insert(lsp_names, client.name)
                  end
                end
              end

              -- Add conform.nvim formatters
              local ok, conform = pcall(require, "conform")
              if ok then
                local formatters = conform.list_formatters_for_buffer()
                for _, name in ipairs(formatters) do
                  table.insert(lsp_names, name)
                end
              end

              -- ? Is this needed because of the cond validation below?
              -- if #lsp_names == 0 then
              --   return lsp .. "no lsp"
              -- end

              return lsp .. table.concat(lsp_names, ", ")
            end,
            cond = lsp_utils.has_attached_lsp_or_formatter,
          },
        },
      },
    })
  end,
}
