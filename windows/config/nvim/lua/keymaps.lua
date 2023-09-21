local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- normal mode
-- 表示行単位で上下移動
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "<Down>", "gj", opts)
keymap("n", "<Up>", "gk", opts)

-- insert mode
keymap("i", "jk", "<ESC>", opts)
