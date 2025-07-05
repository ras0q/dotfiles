-- for avante.nvim's input provider and replacing telescope functionality
return {
  "folke/snacks.nvim",
  lazy = false,
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
  },
  keys = {
    { "<leader>b", function() Snacks.picker.buffers() end,  desc = "Buffers" },
    { "<leader>c", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>e", function() Snacks.explorer() end,        desc = "File Explorer" },
    { "<leader>f", function() Snacks.picker.files() end,    desc = "Find Files" },
    { "<leader>g", function() Snacks.picker.grep() end,     desc = "Live Grep" },
    { "<leader>h", function() Snacks.picker.help() end,     desc = "Help Tags" },
    { "<leader>l", function() Snacks.lazygit() end,         desc = "LazyGit" },
    { "<leader>p", function() Snacks.picker.pickers() end,  desc = "List Pickers" },
  },
}
