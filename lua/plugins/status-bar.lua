-- local status_line = {
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   config = function()
--     local lualine = require("lualine")
--
--     local hide_in_width = function()
--       return vim.fn.winwidth(0) > 80
--     end
--
--     local diagnostics = {
--       "diagnostics",
--       sources = { "nvim_diagnostic" },
--       sections = { "error", "warn" },
--       symbols = { error = " ", warn = " " },
--       colored = false,
--       update_in_insert = false,
--       always_visible = true,
--     }
--
--     local diff = {
--       "diff",
--       colored = false,
--       symbols = { added = "+ ", modified = "~ ", removed = "- " }, -- changes diff symbols
--       cond = hide_in_width,
--     }
--
--     local mode = {
--       "mode",
--       fmt = function(str)
--         return "-- " .. str .. " --"
--       end,
--     }
--
--     local filetype = {
--       "filetype",
--       icons_enabled = false,
--       icon = nil,
--     }
--
--     local branch = {
--       "branch",
--       icons_enabled = true,
--       icon = "",
--       fmt = function(branch)
--         if branch == "" then
--           return "No .git"
--         end
--
--         return branch
--       end,
--     }
--
--     local location = {
--       "location",
--       padding = 0,
--     }
--
--     local filename = {
--       "filename",
--       path = 1,
--     }
--
--     local lsp_info = {
--       function()
--         local current_lsp = "no lsp"
--         local buf_ft = ""
--         local clients
--         if vim.fn.has("wsl") == 1 then
--           buf_ft = vim.bo.filetype
--           clients = vim.lsp.get_clients()
--         else
--           buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--           clients = vim.lsp.get_active_clients()
--         end
--
--         if next(clients) == nil then
--           return current_lsp
--         end
--         for _, client in ipairs(clients) do
--           ---@diagnostic disable-next-line: undefined-field
--           local filetypes = client.config.filetypes
--           if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--             return client.name
--           end
--         end
--         return current_lsp
--       end,
--       icon = " LSP:",
--       theme = "auto",
--     }
--
--     local spaces = function()
--       return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
--     end
--
--     lualine.setup({
--       options = {
--         icons_enabled = true,
--         theme = "auto",
--         component_separators = { left = "|", right = "|" },
--         section_separators = { left = "", right = "" },
--         disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
--         always_divide_middle = true,
--       },
--       sections = {
--         lualine_a = {
--           mode,
--         },
--         lualine_b = {
--           filename,
--         },
--         lualine_c = {
--           -- diagnostics
--           diff,
--         },
--         lualine_x = {
--           -- diff,
--           location,
--           diagnostics,
--           spaces,
--         },
--         lualine_y = {
--           lsp_info,
--           -- location,
--         },
--         lualine_z = {
--           branch,
--         },
--       },
--       inactive_sections = {
--         lualine_a = {},
--         lualine_b = {},
--         -- lualine_c = { "filename" },
--         -- lualine_x = { "location" },
--         lualine_y = {},
--         lualine_z = {},
--       },
--       tabline = {},
--       extensions = {},
--     })
--   end,
-- }
-- ---@diagnostic disable: need-check-nil
-- local function config_custom(colors)
--   -- Eviline config for lualine
--   -- Author: shadmansaleh
--   -- Credit: glepnir
--   local lualine = require("lualine")
--
--   -- Color table for highlights
--   -- stylua: ignore
--
--   local utils = {
--     get_indentation_info = function()
--       local buffer = vim.api.nvim_get_current_buf()
--       local expandtab = vim.api.nvim_buf_get_option(buffer, "expandtab")
--       local shiftwidth = vim.api.nvim_buf_get_option(buffer, "shiftwidth")
--
--       local indentation_info = ""
--       if expandtab then
--         indentation_info = "spaces:" .. shiftwidth
--       else
--         indentation_info = "tabs:" .. shiftwidth
--       end
--
--       return indentation_info
--     end,
--     get_aws_info = function()
--       local aws_info = ''
--       local aws_profile = os.getenv("AWS_PROFILE")
--       local aws_region = os.getenv("AWS_REGION") or os.getenv("CDK_DEPLOY_REGION")
--
--       if aws_profile ~= nil and aws_region ~= nil then
--         aws_info = '  ' .. aws_profile .. ' (' .. aws_region .. ')'
--       end
--
--       return aws_info
--     end
--   }
--
--   local conditions = {
--     buffer_not_empty = function()
--       return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
--     end,
--     hide_in_width = function()
--       return vim.fn.winwidth(0) > 80
--     end,
--     check_git_workspace = function()
--       local filepath = vim.fn.expand("%:p:h")
--       local gitdir = vim.fn.finddir(".git", filepath .. ";")
--       return gitdir and #gitdir > 0 and #gitdir < #filepath
--     end,
--     is_git_repo = function()
--       local output =
--         vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
--       return string.find(output, "true")
--     end,
--   }
--
--   -- Config
--   local config = {
--     options = {
--       -- Disable sections and component separators
--       component_separators = "",
--       section_separators = "|",
--       theme = {
--         -- We are going to use lualine_c an lualine_x as left and
--         -- right section. Both are highlighted by c theme .  So we
--         -- are just setting default looks o statusline
--         normal = { c = { fg = colors.fg, bg = colors.bg } },
--         inactive = { c = { fg = colors.fg, bg = colors.bg } },
--       },
--       disabled_filetypes = {
--         statusline = {},
--         winbar = {},
--       },
--       ignore_focus = {},
--       always_divide_middle = true,
--       globalstatus = true,
--       refresh = {
--         statusline = 1000,
--         tabline = 1000,
--         winbar = 1000,
--       },
--     },
--     sections = {
--       -- these are to remove the defaults
--       lualine_a = {},
--       lualine_b = {},
--       lualine_y = {},
--       lualine_z = {},
--       -- These will be filled later
--       lualine_c = {},
--       lualine_x = {},
--     },
--     inactive_sections = {
--       -- these are to remove the defaults
--       lualine_a = {},
--       lualine_b = {},
--       lualine_y = {},
--       lualine_z = {},
--       lualine_c = {},
--       lualine_x = {},
--     },
--     disabled_filetypes = {
--       "neo-tree",
--       "NvimTree",
--     },
--   }
--
--   -- Inserts a component in lualine_c at left section
--   local function ins_left(component)
--     table.insert(config.sections.lualine_c, component)
--   end
--
--   -- Inserts a component in lualine_x at right section
--   local function ins_right(component)
--     table.insert(config.sections.lualine_x, component)
--   end
--
--   -- ins_left {
--   --   function()
--   --     return '▊'
--   --   end,
--   --   color = { fg = '#ffaa00', bg = colors.bg3 },
--   --   padding = { left = 0, right = 0 }, -- We don't need space before this
--   -- }
--
--   ins_left({
--     function()
--       local current_mode = vim.fn.mode()
--
--       local mode_names = {
--         ["n"] = "Normal",
--         ["no"] = "Operator Pending",
--         ["v"] = "Visual",
--         ["V"] = "V-Line",
--         [""] = "V-Block",
--         ["s"] = "Select",
--         ["S"] = "S-Line",
--         [""] = "S-Block",
--         ["i"] = "Insert",
--         ["R"] = "Replace",
--         ["Rv"] = "V-Replace",
--         ["c"] = "Command",
--         ["cv"] = "Vim-Ex",
--         ["ce"] = "Ex",
--         ["r"] = "Prompt",
--         ["rm"] = "More",
--         ["r?"] = "Confirm",
--         ["!"] = "Shell",
--         ["t"] = "Terminal",
--       }
--
--       local mode = string.lower(mode_names[current_mode])
--
--       return mode
--     end,
--     color = function()
--       local mode_colors = {
--         n = colors.red,
--         i = colors.green,
--         v = colors.blue,
--         V = colors.blue,
--         c = colors.magenta,
--         no = colors.red,
--         s = colors.orange,
--         S = colors.orange,
--         [""] = colors.orange,
--         ic = colors.yellow,
--         R = colors.violet,
--         Rv = colors.violet,
--         cv = colors.red,
--         ce = colors.red,
--         r = colors.cyan,
--         rm = colors.cyan,
--         ["r?"] = colors.cyan,
--         ["!"] = colors.red,
--         t = colors.cyan,
--       }
--       local mode_color = (mode_colors[vim.fn.mode()] or colors.blue)
--
--       return { bg = mode_color, fg = colors.bg3, gui = "bold" }
--     end,
--   })
--
--   -- ins_left {
--   --   -- filesize component
--   --   'filesize',
--   --   color = { fg = colors.fg1, bg = colors.bg2 },
--   --   cond = conditions.buffer_not_empty,
--   --   icon = "󰒋"
--   -- }
--
--   ins_left({
--     "filename",
--     path = 0,
--     cond = conditions.buffer_not_empty,
--     color = { fg = colors.peanut, bg = colors.bg1 },
--   })
--
--   ins_left({
--     "diagnostics",
--     sources = { "nvim_diagnostic" },
--     symbols = { error = " ", warn = " ", info = " " },
--     diagnostics_color = {
--       color_error = { fg = colors.red, bg = colors.bg1 },
--       color_warn = { fg = colors.yellow, bg = colors.bg1 },
--       color_info = { fg = colors.blue, bg = colors.bg1 },
--     },
--   })
--   -- Insert mid section. You can make any number of sections in neovim :)
--   -- for lualine it's any number greater then 2
--   -- ins_left {
--   --   function()
--   --     return '%='
--   --   end,
--   -- }
--
--   ins_right({
--     function()
--       return utils.get_aws_info()
--     end,
--     color = { fg = colors.orange },
--   })
--
--   -- ins_left {
--   ins_right({
--     "diff",
--     -- Is it me or the symbol for modified us really weird
--     symbols = { added = " ", modified = "󰝤 ", removed = " " },
--     diff_color = {
--       added = { fg = colors.green, bg = colors.bg },
--       modified = { fg = colors.orange, bg = colors.bg },
--       removed = { fg = colors.red, bg = colors.bg },
--     },
--     cond = conditions.hide_in_width,
--   })
--
--   ins_right({
--     -- Lsp server name .
--     function()
--       local msg = "no lsp"
--       local buf_ft = ""
--       local clients
--       if vim.fn.has("wsl") == 1 then
--         buf_ft = vim.bo.filetype
--         clients = vim.lsp.get_clients()
--       else
--         buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--         clients = vim.lsp.get_active_clients()
--       end
--
--       if next(clients) == nil then
--         return msg
--       end
--       for _, client in ipairs(clients) do
--         ---@diagnostic disable-next-line: undefined-field
--         local filetypes = client.config.filetypes
--         if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--           return client.name
--         end
--       end
--       return msg
--     end,
--     -- icon = ' LSP:',
--     icon = " ",
--     color = { gui = "italic", fg = colors.pink, bg = colors.bg1 },
--   })
--
--   -- Add components to right sections
--   ins_right({
--     function()
--       return utils.get_indentation_info()
--     end,
--     -- cond = conditions.hide_in_width() and conditions.buffer_not_empty(),
--     color = { fg = colors.fg1, bg = colors.bg1 },
--     icon = "",
--   })
--
--   ins_right({
--     "location",
--     color = { fg = colors.fg1, bg = colors.bg1 },
--     cond = conditions.hide_in_width,
--     icon = "",
--   })
--
--   ins_right({
--     "progress",
--     color = { fg = colors.fg1, bg = colors.bg1 },
--   })
--
--   ins_right({
--     "filetype",
--     fmt = string.lower,
--     icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
--     color = { fg = colors.fg1, bg = colors.bg1 },
--   })
--
--   ins_right({
--     "fileformat",
--     fmt = string.upper,
--     icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
--     color = { fg = colors.fg1, bg = colors.bg1 },
--   })
--
--   ins_right({
--     "o:encoding", -- option component same as &encoding in viml
--     fmt = string.lower, -- I'm not sure why it's upper case either ;)
--     cond = conditions.hide_in_width,
--     color = { fg = colors.fg1, bg = colors.bg1 },
--   })
--
--   ins_right({
--     function()
--       local branch = "Not initialized"
--       if conditions.is_git_repo() == 1 then
--         branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
--         local break_point = 30
--
--         local branch_len = string.len(branch)
--         if branch_len > break_point then
--           local start_branch = string.sub(branch, 1, 17)
--           local end_branch = string.sub(branch, branch_len - 10, branch_len)
--
--           branch = start_branch .. "..." .. end_branch
--         end
--       end
--
--       return branch
--     end,
--     icons_enabled = true,
--     icon = "",
--     color = { fg = colors.bg1, bg = colors.darkblue, gui = "bold" },
--   })
--   -- ins_right {
--   --   function()
--   --     return '▊'
--   --   end,
--   --   color = { fg = '#ffaa00', bg = colors.bg3 },
--   --   padding = { left = 1 },
--   -- }
--
--   -- Now don't forget to initialize lualine
--   lualine.setup(config)
-- end
--
-- local sergio_status_line = {
--   "nvim-lualine/lualine.nvim",
--   dependencies = {
--     {
--       {
--         "nvim-tree/nvim-web-devicons",
--         config = {
--           require("nvim-web-devicons").setup({
--             strict = true,
--             override_by_extension = {
--               plantuml = {
--                 icon = "󰈏",
--                 color = "#ba0d4d",
--                 name = "plantuml",
--               },
--               puml = {
--                 icon = "󰈏",
--                 color = "#ba0d4d",
--                 name = "puml",
--               },
--               astro = {
--                 icon = "",
--                 color = "#EF8547",
--                 name = "astro",
--               },
--             },
--           }),
--         },
--       },
--     },
--   },
--   lazy = false,
--   config = function()
--     -- INFO: default
--
--     -- local colors = {
--     --   bg       = '#17191c',
--     --   bg1      = '#202328',
--     --   bg2      = '#22252a',
--     --   bg3      = '#2d3239',
--     --   fg       = '#bbc2cf',
--     --   yellow   = '#ECBE7B',
--     --   cyan     = '#008080',
--     --   darkblue = '#081633',
--     --   green    = '#98be65',
--     --   orange   = '#FF8800',
--     --   violet   = '#a9a1e1',
--     --   magenta  = '#c678dd',
--     --   blue     = '#51afef',
--     --   red      = '#ec5f67',
--     --   peanut   = "#f6d5a4",
--     -- }
--
--     -- INFO: catppuccin
--
--     -- local catppuccin_palettes = require("catppuccin.palettes")
--     -- local mocha_colors = catppuccin_palettes.get_palette("mocha")
--     -- local latte_colors = catppuccin_palettes.get_palette("latte")
--     --
--     -- local colors = {
--     --   bg       = mocha_colors.mantle,
--     --   bg1      = mocha_colors.mantle,
--     --   bg2      = mocha_colors.mantle,
--     --   bg3      = mocha_colors.mantle,
--     --   fg       = mocha_colors.text,
--     --   fg1      = mocha_colors.subtext0,
--     --   yellow   = mocha_colors.yellow,
--     --   cyan     = mocha_colors.teal,
--     --   green    = mocha_colors.green,
--     --   orange   = mocha_colors.peach,
--     --   violet   = mocha_colors.lavender,
--     --   magenta  = mocha_colors.mauve,
--     --   blue     = mocha_colors.blue,
--     --   darkblue = latte_colors.lavender,
--     --   red      = mocha_colors.red,
--     --   peanut   = mocha_colors.rosewater,
--     --   pink     = mocha_colors.pink
--     -- }
--
--     -- INFO: nightfly
--     --
--     local colors = {
--       bg = "#01101c",
--       bg1 = "#011321",
--       bg2 = "#021829",
--       bg3 = "#021829",
--       fg = "#bdc1c6",
--       fg1 = "#a9acb0",
--       yellow = "#e6c645",
--       cyan = "#7fdbca",
--       green = "#22DA6E",
--       orange = "#E58027",
--       violet = "#c792ea",
--       magenta = "#ae81ff",
--       blue = "#82aaff",
--       darkblue = "#618de8",
--       red = "#EF5350",
--       peanut = "#dbbc74",
--       pink = "#f0a197",
--     }
--
--     config_custom(colors)
--   end,
-- }

-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
local new_status_line = {
  -- enabled = false,
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
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
            "filename",
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
          },
        },
        lualine_c = {},
        lualine_x = {
          {
            "selectioncount",
          },
          {
            "searchcount",
          },
          {
            "diff",
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
        lualine_y = {
          {
            function()
              local current_lsp = "no lsp"
              local buf_ft = ""
              local clients
              if vim.fn.has("wsl") == 1 then
                buf_ft = vim.bo.filetype
                clients = vim.lsp.get_clients()
              else
                buf_ft = vim.api.nvim_get_option_value("filetype", {
                  buf = 0,
                })
                clients = vim.lsp.get_clients()
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
          },
          {
            -- check if there is tmux session running, if it does then do not show the branch. If not then show the branch
            "branch",
          },
        },
        lualine_z = {},
      },
    })
  end,
}

return new_status_line
