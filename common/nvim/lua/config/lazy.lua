-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local specs = {}
local sep = "/"
local config_path = vim.fn.stdpath("config") .. sep .. "lua"
local pattern = "plugins" .. sep .. "**" .. sep
local subdirs = vim.fn.globpath(config_path, pattern, true, true)
for _, dir in ipairs(subdirs) do
  if not dir:match("\\.lua" .. sep .. "$") then
    local lua_files = vim.fn.globpath(dir, "*.lua", true, true)
    if #lua_files > 0 then
      local module = dir
          :gsub(config_path, "")
          :gsub(sep .. "$", "")
          :gsub(sep, ".")
          :gsub("^%.", "")
      table.insert(specs, { import = module })
    end
  end
end

-- Setup lazy.nvim
require("lazy").setup({
  defaults = {
    lazy = true,
  },
  spec = specs,
  checker = {
    enabled = true,
  },
  ui = {
    border = "rounded",
  },
})

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
