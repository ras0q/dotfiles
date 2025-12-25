--- @type LazyPluginSpec
return {
  "nvim-mini/mini.cursorword",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function(_, opts)
    require("mini.cursorword").setup(opts)
  end,
}
