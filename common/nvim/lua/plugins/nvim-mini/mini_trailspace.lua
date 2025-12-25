--- @type LazyPluginSpec
return {
  "nvim-mini/mini.trailspace",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function(_, opts)
    require("mini.trailspace").setup(opts)
  end,
}
