---@type LazyPluginSpec
return {
  "A7Lavinraj/fyler.nvim",
  branch = "stable",
  lazy = false,
  opts = {
    views = {
      finder = {
        default_explorer = true,
        mappings = {
          ["h"] = "CollapseNode",
          ["l"] = "Select",
        },
      },
    },
  },
  keys = {
    { "<leader>e", function() require("fyler").focus() end, desc = "File Explorer" },
  },
}
