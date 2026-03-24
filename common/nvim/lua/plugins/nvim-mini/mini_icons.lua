--- @type LazyPluginSpec
return {
  "nvim-mini/mini.icons",
  lazy = false,
  version = "*",
  opts = {},
  config = function(_, opts)
    require("mini.icons").setup(opts)
  end,
}
