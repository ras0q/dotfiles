-- core
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.fileencoding = "utf-8"
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.shell = "zsh"
vim.opt.mouse = "a"
if vim.fn.has("win32") == 1 then
  vim.opt.shellslash = true

  local msystem = vim.fn.getenv("MSYSTEM")

  if msystem == "MINGW64" or msystem == "MINGW32" then
    vim.opt.shell = '"C:\\Program Files\\Git\\bin\\bash.exe"'
    vim.opt.shellcmdflag = "-c"
    vim.opt.shellxquote = ""
  else
    vim.opt.shell = "pwsh.exe"
    vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
    vim.opt.shellxquote = ""
  end
end
vim.cmd("filetype plugin indent on")

-- appearance
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.fillchars = { eob = " " }
vim.opt.laststatus = 3
vim.opt.virtualedit = "onemore"
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
}
if vim.fn.has("nvim-0.10") == 0 then
  vim.opt.termguicolors = true
end

-- tabs
vim.opt.expandtab = vim.fn.expand("%:r") ~= "Makefile"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true
vim.opt.infercase = true
vim.opt.completeopt = { "menuone", "noselect" }


--- clipboard
vim.opt.clipboard = ""
vim.opt.formatoptions = "qjl1"
vim.opt.shortmess:append("WcC")
vim.opt.splitkeep = "screen"
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "Wsl2Clipboard",
    copy = {
      ["+"] = { "sh", "-c", "nkf -Ws | clip.exe" },
      ["*"] = { "sh", "-c", "nkf -Ws | clip.exe" },
    },
    paste = {
      ["+"] =
      "pwsh.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))",
      ["*"] =
      "pwsh.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))",
    },
    cache_enabled = true,
  }
end

-- netrw
vim.g.netrw_liststyle = 3 -- tree style listing

-- session
vim.opt.sessionoptions:remove({ "blank" })

local M = {
  ai_enabled = os.getenv("NVIM_AI_ENABLED") == "true",
}

return M
