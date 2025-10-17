vim.opt.spell = true
vim.opt.spelllang = { "en", "cjk" }
local function get_eol()
  local ff = vim.bo.fileformat
  if ff == "dos" then
    return "\r\n"
  elseif ff == "mac" then
    return "\r"
  else
    return "\n"
  end
end


vim.keymap.set("i", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  local indent, bullet, rest = line:match("^(%s*)([%-%+%*]%s+[ xX]?)%s*(.*)$")

  if not bullet then
    return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
  end

  local eol = get_eol()

  if #rest > 0 then
    return eol .. bullet
  end

  if #indent > 0 then
    return vim.api.nvim_replace_termcodes("<C-d>", true, false, true)
  end

  return vim.api.nvim_replace_termcodes("<Esc>cc<Esc>o", true, false, true)
end, { buffer = true, expr = true })
