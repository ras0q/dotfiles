--- @type LazyPluginSpec
return {
  "nvim-mini/mini-git",
  version = "*",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("mini.git").setup(opts)
  end,
}
