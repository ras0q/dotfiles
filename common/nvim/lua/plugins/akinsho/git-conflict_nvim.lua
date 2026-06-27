---@type LazyPluginSpec
return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
}
