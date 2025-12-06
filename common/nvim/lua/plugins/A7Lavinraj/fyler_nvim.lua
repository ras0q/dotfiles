---@type LazyPluginSpec
return {
  "A7Lavinraj/fyler.nvim",
  branch = "stable",
  lazy = false,
  opts = {},
  keys = {
    { "<leader>e", function() require("fyler").focus() end, desc = "File Explorer" },
  },
}
