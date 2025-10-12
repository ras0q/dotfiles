vim.keymap.set("i", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  local indent, bullet, rest = line:match("^(%s*)([%-%+%*]%s+[ xX]?)%s*(.*)$")
  local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, true)

  if not bullet then
    return cr
  end

  if #rest > 0 then
    return cr .. bullet
  end

  if #indent > 0 then
    return vim.api.nvim_replace_termcodes("<C-d>", true, false, true)
  end

  return vim.api.nvim_replace_termcodes("<Esc>cc<Esc>o", true, false, true)
end, { buffer = true, expr = true })
