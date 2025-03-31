return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local base = "#0a0911"
    local surface = "#0f0d1a"
    local overlay = "#26233a"
    local muted = "#6e6a86"
    local text = "#e0def4"
    local love = "#eb6f92"
    local rose = "#ebbcba"
    local pine = "#31748f"
    local foam = "#9ccfd8"
    local iris = "#c4a7e7"

    local theme = {
      normal = {
        a = { bg = rose, fg = base, gui = "bold" },
        b = { bg = surface, fg = rose },
        c = { bg = surface, fg = text },
        z = { bg = overlay, fg = rose },
      },
      insert = {
        a = { bg = foam, fg = base, gui = "bold" },
        b = { bg = surface, fg = foam },
        c = { bg = surface, fg = text },
      },
      visual = {
        a = { bg = iris, fg = base, gui = "bold" },
        b = { bg = surface, fg = iris },
        c = { bg = surface, fg = text },
      },
      replace = {
        a = { bg = pine, fg = base, gui = "bold" },
        b = { bg = surface, fg = pine },
        c = { bg = surface, fg = text },
      },
      command = {
        a = { bg = love, fg = base, gui = "bold" },
        b = { bg = surface, fg = love },
        c = { bg = surface, fg = text },
      },
      inactive = {
        a = { bg = base, fg = muted, gui = "bold" },
        b = { bg = base, fg = muted },
        c = { bg = base, fg = muted },
      },
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = theme,
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
              warn = "  ",
              hint = "  ",
              info = "  ",
            },
            colored = true,
            update_in_insert = false,
            always_visible = true,
          },
        },
        lualine_c = {
          {
            "diff",
          },
        },
        lualine_x = {
          {
            "searchcount",
          },
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
            cond = function()
              local has_lsp =
                not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0 }))

              local ok, conform = pcall(require, "conform")
              local has_formatter = false
              if ok then
                local formatters = conform.list_formatters_for_buffer()
                has_formatter = not vim.tbl_isempty(formatters)
              end

              return has_lsp or has_formatter
            end,
          },
        },
      },
    })
  end,
}
