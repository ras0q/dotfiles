local list_repos = {
  finder = "proc",
  cmd = "ghq",
  args = { "list", "--full-path" },
  transform = function(item)
    item.file = item.text
    item.dir = true
  end,
  confirm = function(picker, item)
    picker:close()
    vim.cmd("cd " .. item.text)
  end,
}

--- @type LazyPluginSpec
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  enabled = vim.g.vscode == nil,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { icon = " ", key = "s", desc = "Restore Session", section = "session", padding = 1 },
        { section = "startup" },
      },
    },
    indent = {
      enabled = true,
      scope = { char = "╎" },
    },
    notifier = {
      enabled = true,
      timeout = 5000,
    },
    picker = {
      enabled = true,
      hidden = true,
    },
    quickfile = { enabled = true },
    terminal = {
      win = {
        border = "rounded",
      },
    },
  },
  keys = {
    { "<leader>b", function() Snacks.picker.buffers({ hidden = true }) end,                               desc = "Buffers" },
    { "<leader>c", function() Snacks.picker.files({ hidden = true, cwd = vim.fn.stdpath("config") }) end, desc = "Config" },
    { "<leader>e", function() Snacks.explorer() end,                                                      desc = "File Explorer" },
    { "<leader>f", function() Snacks.picker.files({ hidden = true }) end,                                 desc = "Find Files" },
    { "<leader>g", function() Snacks.picker.grep({ hidden = true }) end,                                  desc = "Live Grep" },
    { "<leader>h", function() Snacks.picker(list_repos) end,                                              desc = "List Repositories" },
    { "<leader>l", function() Snacks.lazygit() end,                                                       desc = "LazyGit" },
    { "<leader>p", function() Snacks.picker.pickers() end,                                                desc = "List Pickers" },
    { "<leader>r", function() Snacks.picker.recent() end,                                                 desc = "List Recent files" },
  },
}
