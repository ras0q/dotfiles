---@param bufnr integer
---@return string
local function label(bufnr)
  local bo = vim.bo[bufnr]
  if bo.buftype == "terminal" then
    -- term_title follows OSC 0/2 from the shell, hence redrawtabline on TermRequest.
    -- Until the shell sets one, it is the full term:// URI, which is too long for a tab.
    local title = vim.b[bufnr].term_title or ""
    if title == "" or vim.startswith(title, "term://") then
      return vim.fn.fnamemodify(title:match("[^:]*$"), ":t")
    end
    return title
  end
  local name = vim.api.nvim_buf_get_name(bufnr)
  return name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t")
end

---@param bufnr integer
---@return string
local function icon(bufnr)
  ---@diagnostic disable-next-line: undefined-field
  if not _G.MiniIcons then
    return ""
  end
  local ft = vim.bo[bufnr].buftype == "terminal" and "terminal" or vim.bo[bufnr].filetype
  ---@diagnostic disable-next-line: undefined-field, undefined-global
  local glyph = ft ~= "" and MiniIcons.get("filetype", ft) or MiniIcons.get("default", "file")
  return glyph .. " "
end

---Rendered via `%!`, so it must stay cheap and must not error: a failure blanks the tabline.
---@return string
function _G.tabline()
  local current = vim.api.nvim_get_current_tabpage()
  local parts = {}
  for i, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local winid = vim.api.nvim_tabpage_get_win(tab)
    local bufnr = vim.api.nvim_win_get_buf(winid)
    -- A literal %m in this string is expanded for the current window only, so every
    -- tab would share one flag. Evaluate it against this tab's window instead.
    local modified = vim.api.nvim_eval_statusline("%m", { winid = winid }).str
    modified = modified ~= "" and (" " .. modified) or ""
    local text = string.format(" %d %s%s%s ", i, icon(bufnr), label(bufnr), modified)
    table.insert(parts, table.concat({
      tab == current and "%#TabLineSel#" or "%#TabLine#",
      "%" .. i .. "T",
      (text:gsub("%%", "%%%%")),
    }))
  end
  return table.concat(parts) .. "%#TabLineFill#%T"
end

vim.opt.tabline = "%!v:lua.tabline()"
