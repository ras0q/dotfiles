local opts = { noremap = true, silent = true }

-- normal mode
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("n", "<Down>", "gj", opts)
vim.keymap.set("n", "<Up>", "gk", opts)
vim.keymap.set("n", "gh", "^", opts)
vim.keymap.set("n", "gl", "$", opts)
vim.keymap.set("n", "ge", "G", opts)
vim.keymap.set("n", "gp", ":bprevious<CR>", opts)
vim.keymap.set("n", "gn", ":bnext<CR>", opts)
vim.keymap.set("n", "<Space>o", ":SearchInBrowser<CR>", opts)
vim.keymap.set("n", "<Space>p", '"+p', opts)
vim.keymap.set("n", "<Space>y", '"+y', opts)
vim.keymap.set("n", "<Space><Space>", "ZZ", opts)
vim.keymap.set("n", "<Plug>(esc)<ESC>", "i<ESC>", opts) -- back to terminal mode

-- insert mode
vim.keymap.set("i", "jk", "<ESC>", opts)

-- visual mode
vim.keymap.set("v", "gh", "g^", opts)
vim.keymap.set("v", "gl", "g$", opts)
vim.keymap.set("v", "ge", "G", opts)
vim.keymap.set("v", "<Space>p", '"+p', opts)
vim.keymap.set("v", "<Space>y", '"+y', opts)

-- terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n><Plug>(esc)", opts)
