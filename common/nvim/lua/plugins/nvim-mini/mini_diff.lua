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
    -- FIXME: need to disable diff?
    -- https://codecompanion.olimorris.dev/installation.html#mini-diff
    -- source = diff.gen_source.none(),
  },
  config = function(_, opts)
    require("mini.diff").setup(opts)
  end,
  keys = {
    { "<leader>D", function() require("mini.diff").toggle_overlay() end, desc = "Toggle diff overlay" },
  },
}
