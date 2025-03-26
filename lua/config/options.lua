-------------------------------------------------------------------------------
-- `:help vim.opt`
-------------------------------------------------------------------------------

-- controls where the cursor is allowed to move, even if there's no actual text at that position.
vim.opt.virtualedit = "block"
-- gives you live preview of your :substitute (:s) commands before you actually hit Enter.
vim.opt.inccommand = "split"
-- neovim by default supports 256 colors. This enables true colors
vim.opt.termguicolors = true
-- controls whether Neovim makes a backup copy of a file before overwriting it when you save.
vim.opt.backup = false
-- configures how Neovim interacts with your system clipboard—so you can copy/paste between Neovim and other apps
vim.opt.clipboard = "unnamedplus"
-- controls the height of the command line area
vim.opt.cmdheight = 1
-- configures how autocomplete menus behave especially, for insert mode completions like LSP, snippets, and nvim-cmp
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- controls how concealed text is displayed
vim.opt.conceallevel = 0
-- determines how the characters are encoded
vim.opt.fileencoding = "utf-8"
-- controls whether Neovim highlights all matches of your last search
vim.opt.hlsearch = true
-- enables mouse support
vim.opt.mouse = "a"
-- sets the maximum number of items shown in the popup menu (completion menu)
vim.opt.pumheight = 10
-- controls whether Neovim displays the current mode
vim.opt.showmode = true
-- controls when the tab line is visible
vim.opt.showtabline = 2
-- makes Neovim case-insensitive when searching
vim.opt.ignorecase = true
-- If your search contains any uppercase letter, it becomes case-sensitive. (NOTE: it only works when ignorecase is enabled)
vim.opt.smartcase = true
-- enables basic smart auto-indenting
vim.opt.smartindent = true
-- force all horizontal splits to go below current window
vim.opt.splitbelow = true
-- force all vertical splits to go right
vim.opt.splitright = true
-- controls if creates a swap file
vim.opt.swapfile = false
-- defines how long it waits before giving up and executing just the first key.
vim.opt.timeoutlen = 1000
-- enables persistent undo, allowing you to undo changes even after closing and reopening a file
vim.opt.undofile = true
-- sets the idle time Neovim waits before triggering certain events (autocmds, writing swap files, lsp, git gutter updates, diagnostics)
vim.opt.updatetime = 300
-- it controls whether Neovim creates a temporary backup copy of your file while writing it
vim.opt.writebackup = false
-- controls whether Neovim inserts spaces instead of tabs
vim.opt.expandtab = true
-- sets the number of spaces used for each step of indentation
vim.opt.shiftwidth = 2
-- defines how many columns a tab character (\t) is visually displayed
vim.opt.tabstop = 2
-- highlights the line where your cursor is in
vim.opt.cursorline = true
-- enables line numbers in editor gutter
vim.opt.number = true
-- it shows the distance from the current line to each other line in the buffer.
vim.opt.relativenumber = true
-- sets the minimum width of the gutter used to display line numbers
vim.opt.numberwidth = 4
-- controls the column on the left of the Neovim window where signs are displayed (NOTE: git signs, diagnostics, ...)
vim.opt.signcolumn = "yes"
-- controls whether wraps long lines onto the next visual line
vim.opt.wrap = true
-- sets the minimum number of lines to keep above and below the cursor when scrolling vertically
vim.opt.scrolloff = 8
-- sets the minimum number of columns to keep to the left and right of the cursor when scrolling sideways
vim.opt.sidescrolloff = 8
-- controls when the statusline is shown
vim.opt.laststatus = 3
-- adds a vertical guide line at a specific column
vim.opt.colorcolumn = "80"
-- enables incremental searching in Neovim—meaning you see matches as you type, rather than waiting until you hit <Enter>
vim.opt.incsearch = true
-- hide ~ on empty lines for a cleaner UI
vim.opt.fillchars:append({ eob = " " })
