return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  config = function()
    -- Header taken from https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=NEOVIM
    local header = [[
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]
    header = string.rep("\n", 8) .. header .. "\n\n"
    local dashboard = require("dashboard")
    dashboard.setup({
      theme = "doom",
      config = {
        header = vim.split(header, "\n"),
        center = {
          {
            icon = " \t",
            desc = "Lazy update              ",
            key = "u",
            action = "Lazy update",
          },
          -- {
          --   icon = '󰓅 \t',
          --   desc = 'Lazy profile              ',
          --   key = 'p',
          --   action = 'Lazy profile'
          -- },
          {
            icon = " \t",
            desc = "Find files           ",
            key = "pp",
            action = "Telescope find_files",
          },
          {
            icon = "󰈞 \t",
            desc = "Find into files           ",
            key = "ff",
            action = "Telescope live_grep",
          },
          -- {
          --   icon = '󱏒 \t',
          --   desc = 'Open tree             ',
          --   key = 't',
          --   action = 'NvimTreeOpen'
          -- },
          -- {
          -- 	icon = " \t",
          -- 	desc = "Neogit              ",
          -- 	key = "n",
          -- 	action = "Neogit",
          -- },
          -- {
          --   icon = ' \t',
          --   desc = 'Find changes',
          --   key = 'd',
          --   action = 'Telescope git_status'
          -- },
          -- {
          --   icon = ' \t',
          --   desc = 'Find branches',
          --   key = 'b',
          --   action = 'Telescope git_branches'
          -- },
          {
            icon = " \t",
            desc = "Change color             ",
            key = "c",
            action = "Telescope colorscheme",
          },
          {
            icon = " \t",
            desc = "Quit               ",
            key = "qq",
            action = "quit",
          },
        },
      },
    })

    -- ? Does this need to go to external file where all of the autocmd will go?
    -- Utility to go to dashboard if last buffer was closed
    vim.defer_fn(function()
      vim.api.nvim_create_autocmd("BufDelete", {
        group = vim.api.nvim_create_augroup(
          "open-dashboard-after-last-buffer-close",
          { clear = true }
        ),
        callback = function(event)
          for buf = 1, vim.fn.bufnr("$") do
            if buf ~= event.buf and vim.fn.buflisted(buf) == 1 then
              if
                vim.api.nvim_buf_get_name(buf) ~= ""
                and vim.bo[buf].filetype ~= "dashboard"
              then
                return
              end
            end
          end

          vim.cmd("Dashboard")
        end,
      })
    end, 0)
  end,
}
