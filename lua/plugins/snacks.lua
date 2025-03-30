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
    indent = { enabled = false },
    input = { enabled = false },
    layout = { enabled = false },
    lazygit = { enabled = true },
    notifier = {
      timeout = 3000, -- default timeout in ms
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- editor margin to keep free. tabline and statusline are taken into account automatically
      -- margin = { top = 10, right = 1, bottom = 0 },
      -- margin = { right = 1, bottom = 10 },
      margin = { top = 0, right = 1, bottom = 1 },
      padding = true, -- add 1 cell of left/right padding to the notification window
      sort = { "level", "added" }, -- sort by level and time
      -- minimum log level to display. TRACE is the lowest
      -- all notifications are stored in history
      level = vim.log.levels.TRACE,
      icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = " ",
      },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      ---@type snacks.notifier.style
      style = "compact",
      top_down = false, -- place notifications from top to bottom
      date_format = "%R", -- time format for notifications
      -- format for footer when more lines are available
      -- `%d` is replaced with the number of lines.
      -- only works for styles with a border
      ---@type string|boolean
      more_format = " ↓ %d lines ",
      refresh = 50, -- refresh at most every 50ms
    },
    notify = { enabled = false },
    picker = {
      sources = {
        explorer = {
          auto_close = true,
        },
      },
    },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    rename = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = false },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
  },
}
