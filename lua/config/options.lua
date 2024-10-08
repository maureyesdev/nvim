-- options -- for any help `:help opts`

vim.opt.virtualedit = "block" -- Do I need this?
vim.opt.inccommand = "split"
vim.opt.termguicolors = true

vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the condigin written to a file
vim.opt.hlsearch = true -- highligh all matches on previous searhch patterns
vim.opt.ignorecase = true -- ignore case in search pattern
-- vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up meny height
vim.opt.showmode = false -- like INSERT NORMAL VISUAL REPLACE
vim.opt.showtabline = 2 -- tabs control => 0: never, 1: always, 2: only when more than one tab
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
-- ? Would it be possible to use this to recognize the language and set the appropriate indent?
vim.opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.opt.linebreak = true -- wrap lines at convenient points
vim.opt.breakindent = true -- indent wrapped lines
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go right
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edit
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = false -- highlight the current line
vim.opt.number = true -- set numbered line
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true -- display lines as one long line
vim.opt.scrolloff = 12
vim.opt.sidescrolloff = 12

-- folding options
vim.opt.foldcolumn = "0" -- To avoid viewing the folding context
vim.opt.foldlevelstart = 99 -- To avoid collapsing the folding at start
-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value ? Not sure if I need this
-- vim.o.foldenable = true -- ? Not sure if I need this

vim.opt.fillchars:append({ eob = " " }) -- To remove anoying ~ for empty lines or unused lines in editor file

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.laststatus = 3
-------------------------------------------------------------------------------
-- ! THE FOLLOWING SETTINGS NEED TO BE REVIEWED
-------------------------------------------------------------------------------

vim.opt.colorcolumn = "80"

vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
