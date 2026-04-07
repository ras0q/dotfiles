---@type LazyPluginSpec
return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  lazy = false,
  opts = {},
  keys = {
    { "<Leader>e", function() require("fyler").toggle() end, desc = "Open Fyler" },
  },
}
