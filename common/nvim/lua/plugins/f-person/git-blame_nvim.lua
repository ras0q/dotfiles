---@type LazyPluginSpec
return {
  "f-person/git-blame.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
}
