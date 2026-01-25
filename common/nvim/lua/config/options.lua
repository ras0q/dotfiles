-- core
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.autoread = true
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.mouse = "a"
vim.opt.shell = vim.env.SHELL or "zsh"
vim.opt.exrc = true

-- appearance
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
}
vim.g.netrw_liststyle = 3 -- tree style listing
vim.schedule(function()
  vim.opt.laststatus = 3
end)

-- tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true
vim.opt.infercase = true

-- session
vim.opt.sessionoptions:remove({ "blank" })

-- clipboard (OSC 52)
local is_wsl2 = vim.fn.has("wsl") == 1
local is_ssh = os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil
if is_wsl2 or is_ssh then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    },
    paste = {
      ["+"] = function()
        return {
          vim.fn.split(vim.fn.getreg(""), "\n"),
          vim.fn.getregtype(""),
        }
      end,
    },
    cache_enabled = true,
  }
end

local is_win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
local is_msys = vim.fn.getenv("MSYSTEM") ~= nil
if is_win then
  vim.opt.shellslash = true

  if is_msys then
    vim.opt.shell = '"C:\\Program Files\\Git\\bin\\bash.exe"'
    vim.opt.shellcmdflag = "-c"
    vim.opt.shellxquote = ""
  else
    vim.opt.shell = "pwsh.exe"
    vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
    vim.opt.shellxquote = ""
  end
end

local M = {
  ai_enabled = os.getenv("NVIM_AI_ENABLED") == "true",
}

return M
