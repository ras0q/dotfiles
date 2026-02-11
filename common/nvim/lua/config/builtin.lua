vim.cmd.packadd("cfilter")

-- Disable unused default plugins to improve startup time
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logipat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_matchit = 1    -- matchit is enabled by default in Neovim
vim.g.loaded_matchparen = 1 -- we use mini.cursorword instead
vim.g.loaded_netrw = 1      -- prefer file_browser or oil.nvim
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
