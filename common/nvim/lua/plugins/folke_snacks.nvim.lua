-- for avante.nvim's input provider and replacing telescope functionality
return {
  "folke/snacks.nvim",
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = { enabled = true },
    picker = { enabled = true },
  },
  keys = {
    { "<leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>c", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>f", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>g", function() Snacks.picker.grep() end, desc = "Live Grep" },
    { "<leader>h", function() Snacks.picker.help() end, desc = "Help Tags" },
    { "<leader>p", function() Snacks.picker.pickers() end, desc = "List Pickers" },
  },
}
