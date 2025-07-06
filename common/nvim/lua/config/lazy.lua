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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local specs = {}
local sep = package.config:sub(1, 1)
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
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  -- checker = { enabled = true },
})
