vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

local start_on_normal_mode = function()
  vim.cmd.stopinsert()
end

local headers = {
  [[
│ ╲ ││
││╲╲││
││ ╲ │
  ]],
}

local version = vim.version()
local nvim_version =
  string.format("v%d.%d.%d", version.major, version.minor, version.patch)

local function random_header()
  math.randomseed(os.time())
  local index = math.random(1, #headers)
  return headers[index]
end

local header = random_header() .. "\n" .. "NVIM" .. " " .. nvim_version

require("snacks").setup({
  animate = { enabled = false },
  bigfile = { enabled = false },
  bufdelete = { enabled = false },
  dashboard = {
    enabled = true,
    preset = { header = header },
    sections = {
      { section = "header" },
    },
  },
  debug = { enabled = false },
  dim = { enabled = false },
  explorer = { enabled = true },
  git = { enabled = false },
  gitbrowse = { enabled = false },
  image = { enabled = false },
  indent = {
    enabled = true,
    filter = function(buffer)
      return vim.g.snacks_indent ~= false
        and vim.b[buffer].snacks_indent ~= false
        and vim.bo[buffer].buftype == ""
        and vim.bo[buffer].filetype ~= "dashboard"
    end,
  },
  input = { enabled = false },
  layout = { enabled = false },
  lazygit = {
    configure = true,
  },
  notifier = { enabled = false },
  notify = { enabled = false },
  picker = {
    sources = {
      explorer = {
        auto_close = false,
        layout = {
          layout = {
            position = "right",
          },
        },
      },
      buffers = {
        layout = { preset = "vscode" },
        on_show = start_on_normal_mode,
        win = {
          input = {
            keys = {
              ["d"] = "bufdelete",
            },
          },
          list = {
            keys = {
              ["d"] = "bufdelete",
            },
          },
        },
      },
      git_status = {
        on_show = start_on_normal_mode,
      },
      diagnostics = {
        layout = { preset = "ivy", preview = "main" },
        on_show = start_on_normal_mode,
      },
      select = {
        on_show = start_on_normal_mode,
      },
      picker_actions = {
        on_show = start_on_normal_mode,
      },
      commands = {
        layout = { preset = "vscode" },
      },
      files = {
        layout = { preset = "vscode" },
      },
      grep = {
        layout = { preset = "sidebar" },
        regex = false,
      },
      lines = {
        layout = { preset = "vscode" },
      },
      lsp_symbols = {
        { layout = { preset = "vscode" } },
      },
      lsp_references = {},
      lsp_implementations = {},
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
})
