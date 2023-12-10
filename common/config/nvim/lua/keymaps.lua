local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- normal mode
-- 表示行単位で上下移動
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "<Down>", "gj", opts)
keymap("n", "<Up>", "gk", opts)
-- open terminal
keymap("n", "tt", ":split | wincmd j | resize 10 | terminal<CR>i", opts)

-- insert mode
keymap("i", "jk", "<ESC>", opts)

-- terminal mode
keymap("t", "<ESC>", "<C-\\><C-n>", opts)
