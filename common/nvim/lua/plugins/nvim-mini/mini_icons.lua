--- @type LazyPluginSpec
return {
  "nvim-mini/mini.icons",
  version = "*",
  lazy = false,
  priority = 1000,
  opts = {
    filetype = {
      terminal = { glyph = " ", hl = "MiniIconsGray" },
    },
  },
  config = function(_, opts)
    require("mini.icons").setup(opts)
  end,
}
