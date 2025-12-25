--- @type LazyPluginSpec
return {
  "nvim-mini/mini.icons",
  version = "*",
  lazy = false,
  opts = {},
  config = function(_, opts)
    require("mini.icons").setup(opts)
  end,
}
