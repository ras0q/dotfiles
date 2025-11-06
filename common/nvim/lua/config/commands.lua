vim.api.nvim_create_user_command("AddPlugin", function(opts)
  local spec = opts.fargs[1]
  if not spec or not spec:match("^[^/]+/.+$") then
    return vim.notify("Argument must be in 'author/repo' format", vim.log.levels.ERROR)
  end

  local filename = spec:gsub("%.", "_")
  local path = string.format("%s/lua/plugins/%s.lua", vim.fn.stdpath("config"), filename)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")

  local file = io.open(path, "w")
  if file then
    file:write(
      string.format('---@type LazyPluginSpec\nreturn {\n  "%s",\n  event = "VeryLazy",\n  opts = {},\n}\n', spec)
    )
    file:close()
    vim.notify("✅ Created: " .. vim.fn.fnamemodify(path, ":~"), vim.log.levels.INFO)
  end
end, { nargs = 1 })

vim.api.nvim_create_user_command("SearchInBrowser", function()
  vim.ui.input({ prompt = "Search: " }, function(input)
    if input ~= nil and input ~= "" then
      local url = "https://www.google.com/search?q=" .. input

      if vim.g.netrw_browsex_viewer ~= nil and vim.g.netrw_browsex_viewer ~= "" then
        vim.fn.system({ vim.g.netrw_browsex_viewer, url })
        return
      end

      if vim.env.BROWSER ~= nil and vim.env.BROWSER ~= "" then
        vim.fn.system({ vim.env.BROWSER, url })
        return
      end

      if vim.fn.has("mac") == 1 then
        vim.fn.system({ "open", url })
      elseif vim.fn.has("win32") == 1 then
        vim.fn.system({ "start", url })
      else
        vim.fn.system({ "xdg-open", url })
      end
    end
  end)
end, {})
