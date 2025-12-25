--- @type LazyPluginSpec
return {
  "nvim-mini/mini.ai",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function(_, opts)
    require("mini.ai").setup(opts)
  end,
}
