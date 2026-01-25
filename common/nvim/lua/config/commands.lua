vim.api.nvim_create_user_command("DotfilesUpdate", function()
  local dotfiles = vim.env.DOTFILES
  if not dotfiles or dotfiles == "" then
    vim.notify("$DOTFILES is not set", vim.log.levels.ERROR)
    return
  end

  local cmd = "git -C " .. dotfiles .. " pull --rebase"
  local output = vim.fn.systemlist(cmd)
  local exit_code = vim.v.shell_error

  if exit_code == 0 then
    vim.notify("Dotfiles updated successfully", vim.log.levels.INFO)
  else
    vim.notify("Failed to update dotfiles:\n" .. table.concat(output, "\n"), vim.log.levels.ERROR)
  end
end, {})

vim.api.nvim_create_user_command("PluginAdd", function(opts)
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

-- https://zenn.dev/vim_jp/articles/ff6cd224fab0c7
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local current_win = vim.api.nvim_get_current_win()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if win ~= current_win then
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == "" then
          return
        end
      end
    end
    vim.cmd.only({ bang = true })
  end,
  desc = "Close all special buffers and quit Neovim",
})

-- https://eiji.page/blog/neovim-highlight-on-yank/
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})
