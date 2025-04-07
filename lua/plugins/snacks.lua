-- Is this the right place of doing this?
local start_on_normal_mode = function()
  vim.cmd.stopinsert()
end

local version = vim.version()
local nvim_version =
  string.format("v%d.%d.%d", version.major, version.minor, version.patch)

return {

  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = false },
    bufdelete = { enabled = false },
    dashboard = {
      preset = {
        header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠤⠤⠴⠒⠒⠒⠶⠶⠶⠤⠤⠴⠶⠶⠤⠤⠤⠤⠤⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠟⠉⢀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣈⠱⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠟⢁⣠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣷⡈⠛⢦⣄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⡴⠻⠋⣺⣽⡿⠀⠀⠀⠀⣀⡀⠀⠀⠆⠀⠀⠀⠀⠀⠀⢠⣴⣦⣀⠀⠀⠀⠘⣿⣦⡀⠙⢷⣄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣀⣴⠟⠁⡠⣴⡇⡸⠁⠀⢠⣾⣿⣿⣿⣷⣠⠀⠀⠀⠀⠀⠀⠀⢼⣿⣿⣿⣿⣦⠀⠀⢸⠹⣷⣄⠀⠙⣿⡀⠀⠀⠀⠀
⠀⠀⢰⡞⠉⠁⠀⠤⠊⢠⡿⢱⠇⠀⠐⢛⡿⠿⠿⢿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠈⢿⠛⣿⣿⠛⠁⠀⠹⡷⣿⡇⠳⢄⡈⠳⢶⣦⡀⠀
⠀⠠⣾⠃⠀⡀⠀⠀⠀⢸⡇⣿⠀⠀⠀⠀⠀⠀⣠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢢⠀⠀⠀⠀⠀⠀⠹⣿⡇⠀⢄⢈⠢⣀⣿⡷⠦
⠀⣼⡷⠀⢀⠔⠂⡰⠁⢈⡇⡇⠀⠀⠀⠀⢀⡴⠁⠀⠀⣠⣶⣶⣿⣿⣿⣶⣦⡀⠀⠀⠳⡀⠀⠀⠀⠀⠀⣿⣧⡀⠀⡙⠱⣌⢻⣿⡂
⠰⢿⣧⠞⢁⡤⠊⠀⠀⣼⣇⡇⠀⡠⠔⠊⠁⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠈⠑⠢⢄⠀⢠⣿⡟⡇⠠⡘⢦⠈⢺⣯⠁
⠀⠸⣿⠶⠋⣠⠎⢀⡞⠙⣿⡇⠀⡇⣸⡀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⣀⠈⡆⣸⣿⡻⠀⠀⠻⣄⡳⣼⣿⡀
⠀⠀⢿⣶⠏⢁⣶⠟⠀⠀⣿⣧⠀⠀⣿⣿⡄⠀⠀⠀⠀⠀⠈⠉⢻⣿⣛⠉⠀⠀⠀⠀⠀⢠⣾⣿⡆⠁⣿⡟⡇⠀⣦⡑⠂⣱⣿⣿⠇
⠀⠀⠈⢻⣷⡊⠀⢀⣀⢤⢿⡟⢴⠄⠘⣻⣿⣄⡀⠀⠀⠀⣀⣠⢿⡿⣄⣀⡀⠀⠀⠠⣴⢿⣿⡿⠁⢰⣿⡇⢣⠀⢌⣣⣷⠟⠁⠀⠀
⠀⠀⠀⠀⠙⣿⣿⣋⡿⢫⣿⣧⣰⠀⠀⢇⢻⣏⠉⡛⡟⠋⠉⠀⢸⡇⠀⠉⠉⣻⣿⠟⠁⢰⡟⠀⠀⣼⣿⣇⢠⡇⣸⠟⠏⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠘⠿⠿⠶⣿⢿⣿⡏⡄⠀⠈⣶⢿⡀⢸⣷⠀⠀⠀⠸⠀⠀⠀⢀⣿⡟⠀⢠⡿⠀⠀⣄⠹⠻⣿⣄⣹⠏⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣰⢸⡏⠀⢼⡟⢡⡀⠀⠸⣈⢷⡈⢻⡄⠀⠀⠀⠀⠀⠀⢸⡟⠁⢠⣿⠃⢸⣾⣿⠀⠀⢻⡙⠏⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢉⢸⠁⠀⠘⢇⣾⠁⠀⠀⠙⡆⠳⡌⢷⡀⠀⠀⠀⠀⣠⡟⣠⣶⡿⠃⠈⡈⠛⣇⠀⠀⢸⠧⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⣸⡆⠀⠀⢸⣡⣶⣇⠀⠀⠈⢦⡙⢦⡛⠶⠦⠤⠖⣫⣾⣿⡿⠀⣤⢠⣇⠀⠁⠀⢠⢿⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣏⢿⡄⠀⠘⢻⣿⠿⡇⠀⠀⠀⠉⠪⣿⣿⣶⣶⣾⣟⡩⠀⠀⠀⣿⣼⡟⠀⠀⠀⡞⣤⠇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠘⡌⣷⡀⠀⠈⢻⣴⣷⣶⠀⠀⠀⡀⠀⠉⠚⠓⠚⠁⠀⠀⠀⠐⣿⠿⠀⠀⠀⡸⢁⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣎⠃⠀⠀⠀⠋⢃⣸⡺⠂⠀⣧⡼⢷⡄⢠⣄⡄⢀⣼⡟⣰⠻⠀⠀⠀⡰⢡⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠣⡀⠀⠀⠀⠛⠙⠁⠀⠘⠛⠁⢻⣿⠋⣿⡧⠈⢈⡴⠁⠀⠀⠀⠀⢁⠜⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⠉⠀⠙⠁⠰⠋⠀⠀⠀⠀⠀⠴⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]
          .. "\nNeovim "
          .. nvim_version,
      },
      sections = {
        { section = "header" },
        -- { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    debug = { enabled = false },
    dim = { enabled = false },
    explorer = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = false },
    image = { enabled = false },
    indent = { enabled = true },
    input = { enabled = false },
    layout = { enabled = false },
    lazygit = {
      configure = true,
      config = {
        os = { editPreset = "nvim-remote" },
        gui = {
          nerdFontsVersion = "3",
        },
      },
    },
    notifier = {
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,
      sort = { "level", "added" },
      level = vim.log.levels.TRACE,
      icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = " ",
      },
      keep = function()
        return vim.fn.getcmdpos() > 0
      end,
      ---@type snacks.notifier.style
      style = "compact",
      top_down = false,
      date_format = "%R",
      ---@type string|boolean
      more_format = " ↓ %d lines ",
      refresh = 50,
    },
    notify = { enabled = false },
    picker = {
      sources = {
        explorer = {
          auto_close = true,
        },
        buffers = {
          on_show = start_on_normal_mode,
          win = {
            input = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
            list = { keys = { ["d"] = "bufdelete" } },
          },
        },
        diagnostics = {
          on_show = start_on_normal_mode,
        },
        select = {
          on_show = start_on_normal_mode,
        },
        picker_actions = {
          on_show = start_on_normal_mode,
        },
      },
    },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    rename = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = {
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = { open = false, git_hl = false },
      git = { patterns = { "GitSign" } },
      refresh = 50,
    },
    terminal = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = false },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
  },
}
