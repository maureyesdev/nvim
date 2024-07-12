return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " " },
      colored = false,
      update_in_insert = false,
      always_visible = true,
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = "+ ", modified = "~ ", removed = "- " }, -- changes diff symbols
      cond = hide_in_width,
    }

    local mode = {
      "mode",
      fmt = function(str)
        return "-- " .. str .. " --"
      end,
    }

    local filetype = {
      "filetype",
      icons_enabled = false,
      icon = nil,
    }

    local branch = {
      "branch",
      icons_enabled = true,
      icon = "",
      fmt = function(branch)
        if branch == "" then
          return "No .git"
        end

        return branch
      end,
    }

    local location = {
      "location",
      padding = 0,
    }

    local filename = {
      "filename",
      path = 1,
    }

    local lsp_info = {
      function()
        local current_lsp = "no lsp"
        local buf_ft = ""
        local clients
        if vim.fn.has("wsl") == 1 then
          buf_ft = vim.bo.filetype
          clients = vim.lsp.get_clients()
        else
          buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          clients = vim.lsp.get_active_clients()
        end

        if next(clients) == nil then
          return current_lsp
        end
        for _, client in ipairs(clients) do
          ---@diagnostic disable-next-line: undefined-field
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return current_lsp
      end,
      icon = " LSP:",
    }

    local spaces = function()
      return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {
          mode,
        },
        lualine_b = {
          filename,
        },
        lualine_c = {
          -- diagnostics
          diff,
        },
        lualine_x = {
          -- diff,
          location,
          diagnostics,
          spaces,
        },
        lualine_y = {
          lsp_info,
          -- location,
        },
        lualine_z = {
          branch,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        -- lualine_c = { "filename" },
        -- lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end,
}
