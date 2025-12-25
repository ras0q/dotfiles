--- @type LazyPluginSpec
return {
  "nvim-mini/mini.surround",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function(_, opts)
    require("mini.surround").setup(opts)
  end,
}
