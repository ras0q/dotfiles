---@type LazyPluginSpec
return {
  "A7Lavinraj/fyler.nvim",
  version = "2.0.0",
  dependencies = { "nvim-mini/mini.icons" },
  lazy = false,
  opts = {},
  keys = {
    { "<Leader>e", function() require("fyler").toggle() end, desc = "Open Fyler" },
  },
}
