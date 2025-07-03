local opt = vim.opt

-- core
opt.fileencoding = "utf-8"
opt.clipboard = "unnamedplus"

-- appearance
opt.number = true
opt.cursorline = true
opt.virtualedit = "onemore"
opt.smartindent = true

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

-- netrw
vim.g.netrw_liststyle = 3 -- tree style listing

local M = {
  ai_enabled = os.getenv("NVIM_AI_ENABLED") == "true"
}
if (not M.ai_enabled) then
  vim.notify("Tips: You can enable AI feature with setting `$NVIM_AI_ENABLED` to `true`")
end

return M
