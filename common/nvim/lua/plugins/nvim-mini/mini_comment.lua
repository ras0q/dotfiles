--- @type LazyPluginSpec
return {
  "nvim-mini/mini.comment",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    mappings = {
      comment = "<C-c>",
      comment_line = "<C-c>",
      comment_visual = "<C-c>",
      textobject = "<C-c>",
    },
  },
  config = function(_, opts)
    require("mini.comment").setup(opts)
  end,
}
