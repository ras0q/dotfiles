local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- normal mode
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "<Down>", "gj", opts)
keymap("n", "<Up>", "gk", opts)
keymap("n", "gh", "g^", opts)
keymap("n", "gl", "g$", opts)
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

-- clipboard
if vim.fn.system('uname -a | grep microsoft') ~= '' then
  local command = '"+y:lua vim.fn.system("clip.exe", vim.fn.getreg(\'"\'))<CR>'
  keymap("n", "<leader>y", command, opts)
  keymap("v", "<leader>y", command, opts)
end
