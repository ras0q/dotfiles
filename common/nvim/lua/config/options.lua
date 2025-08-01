local opt = vim.opt

-- core
opt.fileencoding = "utf-8"
opt.autoread = true
if vim.fn.has("win32") == 1 then
  local msystem = vim.fn.getenv("MSYSTEM")

  if msystem == "MINGW64" or msystem == "MINGW32" then
    opt.shell = '"C:\\Program Files\\Git\\bin\\bash.exe"'
    opt.shellcmdflag = "-c"
    opt.shellxquote = ""
  else
    opt.shell = "pwsh.exe"
    opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
    opt.shellxquote = ""
  end
end

-- appearance
opt.number = true
opt.cursorline = true
opt.virtualedit = "onemore"
opt.smartindent = true

-- tabs
opt.expandtab = vim.fn.expand("%:r") ~= "Makefile" -- Makefileのときはタブ、それ以外はスペース
opt.tabstop = 2
opt.shiftwidth = 2

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = true

--- LSP
opt.completeopt = {
  "fuzzy",
  "popup",
  "menuone",
  "noinsert",
}
vim.diagnostic.config({
  virtual_lines = true,
})

--- clipboard
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
opt.clipboard = "unnamedplus"

-- netrw
vim.g.netrw_liststyle = 3 -- tree style listing

local M = {
  ai_enabled = os.getenv("NVIM_AI_ENABLED") == "true"
}
if (not M.ai_enabled) then
  vim.notify("Tips: You can enable AI feature with setting `$NVIM_AI_ENABLED` to `true`")
end

return M
