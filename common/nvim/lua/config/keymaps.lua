local opts = { noremap = true, silent = true }

local function open_directory_buffer()
  local current = vim.api.nvim_buf_get_name(0)
  local target = current ~= "" and vim.fs.dirname(current) or vim.uv.cwd() or "."
  vim.cmd.edit(vim.fn.fnameescape(target))
end

-- normal mode
vim.keymap.set("n", "gh", "^", opts)
vim.keymap.set("n", "gl", "$", opts)
vim.keymap.set("n", "<Leader>e", open_directory_buffer, { desc = "Open directory" })
vim.keymap.set("n", "<Leader>o", ":SearchInBrowser<CR>", opts)
vim.keymap.set("n", "<Plug>(esc)<ESC>", "i<ESC>", opts) -- back to terminal mode
vim.keymap.set("n", "<Leader>p", '"+p', opts)
vim.keymap.set("n", "<Leader>y", '"+y', opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- insert mode
vim.keymap.set("i", "jk", "<ESC>", opts)
-- record undo breakpoints
vim.keymap.set("i", "<Leader>", "<Leader><C-g>u", opts)
vim.keymap.set("i", ",", ",<C-g>u", opts)
vim.keymap.set("i", ".", ".<C-g>u", opts)
vim.keymap.set("i", "、", "、<C-g>u", opts)
vim.keymap.set("i", "。", "。<C-g>u", opts)

-- visual mode
vim.keymap.set("v", "gh", "^", opts)
vim.keymap.set("v", "gl", "$", opts)
vim.keymap.set("v", "<Leader>p", '"+p', opts)
vim.keymap.set("v", "<Leader>y", '"+y', opts)

-- terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n><Plug>(esc)", opts)

-- command mode
vim.cmd([[
  " Git
  cabbr g   Git
  cabbr G   Git
  cabbr ga  Git add --all --verbose
  cabbr gc  Git commit --verbose
  cabbr gd  Git diff
  cabbr gD  Git restore
  cabbr gDS Git restore --staged
  cabbr gf  Git fetch
  cabbr gl  Git log --oneline
  cabbr gm  Git merge
  cabbr gp  Git pull
  cabbr gpr Git pull --rebase
  cabbr gP  Git push
  cabbr gP! Git push --force-with-lease --force-if-includes
  cabbr gr  Git rebase
  cabbr gs  Git switch
  cabbr gt  Git stash
  cabbr gw  Git worktree

  " Terminal
  cabb ht split <bar> resize 10 <bar> terminal
  cabb vt vsplit <bar> terminal
  cabb tt tab terminal
]])
