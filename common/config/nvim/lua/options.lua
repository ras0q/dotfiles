local opt = vim.opt

-- core
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
vim.scriptencoding = "utf-8"

-- appearance
opt.number = true
opt.cursorline = true
opt.virtualedit = "onemore"
opt.smartindent = true
opt.list = true
opt.listchars = { tab = ">>", trail = "-", nbsp = "+" }

-- tabs
opt.expandtab = vim.fn.expand("%:r") ~= 'Makefile' -- Makefileのときはタブ、それ以外はスペース
opt.tabstop = 2
opt.shiftwidth = 2

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = true

-- backup
opt.backup = false
opt.swapfile = false
