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

-- for avante.nvim's input provider and replacing telescope functionality
return {
  "folke/snacks.nvim",
  version = "v2.22.0",
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    explorer = { enabled = true },
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
    { "<leader>b", function() Snacks.picker.buffers({ hidden = true }) end, desc = "Buffers" },
    { "<leader>e", function() Snacks.explorer() end,                        desc = "File Explorer" },
    { "<leader>f", function() Snacks.picker.files({ hidden = true }) end,   desc = "Find Files" },
    { "<leader>h", function() Snacks.picker(list_repos) end,                desc = "List Repositories" },
    { "<leader>g", function() Snacks.picker.grep({ hidden = true }) end,    desc = "Live Grep" },
    { "<leader>l", function() Snacks.lazygit() end,                         desc = "LazyGit" },
    { "<leader>p", function() Snacks.picker.pickers() end,                  desc = "List Pickers" },
    { "<leader>r", function() Snacks.picker.recent() end,                   desc = "List Recent files" },
  },
}
