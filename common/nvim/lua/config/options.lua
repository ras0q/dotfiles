-- core
vim.opt.fileencoding = "utf-8"
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.shell = "zsh"
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

-- appearance
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.virtualedit = "onemore"
vim.opt.smartindent = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
}

-- tabs
vim.opt.expandtab = vim.fn.expand("%:r") ~= "Makefile" -- Makefileのときはタブ、それ以外はスペース
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true

--- clipboard
vim.opt.clipboard = ""
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
-- if (not M.ai_enabled) then
--   vim.print("Tips: You can enable AI feature with setting `$NVIM_AI_ENABLED` to `true`")
-- end

return M
