---@type LazyPluginSpec
return {
  "nvim-mini/mini.statusline",
  version = "*",
  lazy = false,
  opts = {},
  config = function(_, opts)
    require("mini.statusline").setup(opts)
  end,
}
