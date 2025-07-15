local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- normal mode
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "<Down>", "gj", opts)
keymap("n", "<Up>", "gk", opts)
keymap("n", "gh", "^", opts)
keymap("n", "gl", "$", opts)
keymap("n", "ge", "G", opts)
keymap("n", "gp", ":bprevious<CR>", opts)
keymap("n", "gn", ":bnext<CR>", opts)
keymap("n", "<Space><Space>", "ZZ", opts)
keymap("n", "<Plug>(esc)<ESC>", "i<ESC>", opts) -- back to terminal mode

-- insert mode
keymap("i", "jk", "<ESC>", opts)

-- visual mode
keymap("v", "gh", "g^", opts)
keymap("v", "gl", "g$", opts)
keymap("v", "ge", "G", opts)

-- terminal mode
keymap("t", "<ESC>", "<C-\\><C-n><Plug>(esc)", opts)
