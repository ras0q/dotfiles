---@type LazyPluginSpec
return {
  "f-person/git-blame.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    date_format = "%Y-%m-%d %H:%M:%S",
    delay = 100,
  },
}
