vim.api.nvim_create_user_command("AddPlugin", function(opts)
  local spec = opts.fargs[1]
  if not spec or not spec:match("^[^/]+/.+$") then
    return vim.notify("Argument must be in 'author/repo' format", vim.log.levels.ERROR)
  end

  local path = string.format("%s/lua/plugins/%s.lua", vim.fn.stdpath("config"), spec)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")

  local file = io.open(path, "w")
  if file then
    file:write(string.format('return {\n  "%s",\n}\n', spec))
    file:close()
    vim.notify("✅ Created: " .. vim.fn.fnamemodify(path, ":~"), vim.log.levels.INFO)
  end
end, { nargs = 1 })
