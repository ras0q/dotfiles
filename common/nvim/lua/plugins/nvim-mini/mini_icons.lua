--- @type LazyPluginSpec
return {
  "nvim-mini/mini.icons",
  version = "*",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("mini.icons").setup(opts)
  end,
}
