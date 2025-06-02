local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- normal mode
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "<Down>", "gj", opts)
keymap("n", "<Up>", "gk", opts)
keymap("n", "gh", "^", opts)
keymap("n", "gl", "$", opts)
keymap("n", "<Space><Space>", "ZZ", opts)

-- insert mode
keymap("i", "jk", "<ESC>", opts)
