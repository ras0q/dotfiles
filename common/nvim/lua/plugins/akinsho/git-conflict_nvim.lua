---@type LazyPluginSpec
return {
  "akinsho/git-conflict.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
}
