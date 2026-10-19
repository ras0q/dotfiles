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

-- https://eiji.page/blog/neovim-highlight-on-yank/
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermRequest", {
  callback = function(ev)
    vim.cmd("redrawtabline")

    local data = ev.data or {}
    local sequence = data.sequence
    local terminator = data.terminator
    if type(sequence) ~= "string" or type(terminator) ~= "string" then
      return
    end
    -- :terminal consumes OSC, so WezTerm never sees desktop notifications.
    if sequence:match("^\027%]9;") or sequence:match("^\027%]777;notify") then
      vim.api.nvim_ui_send(sequence .. terminator)
    end
  end,
})
