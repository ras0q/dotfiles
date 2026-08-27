---@type LazyPluginSpec
return {
  "nvim-mini/mini.jump",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function(_, opts)
    require("mini.jump").setup(opts)
  end,
}
