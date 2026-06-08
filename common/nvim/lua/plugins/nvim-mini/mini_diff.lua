--- @type LazyPluginSpec
return {
  "nvim-mini/mini.diff",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    mappings = {
      apply = "gda",
      reset = "gdr",
      textobject = "gda",
    },
  },
  config = function(_, opts)
    require("mini.diff").setup(opts)
  end,
  keys = {
    { "<leader>D", function() require("mini.diff").toggle_overlay() end, desc = "Toggle diff overlay" },
  },
}
