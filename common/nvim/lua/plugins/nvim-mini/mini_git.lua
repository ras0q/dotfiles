--- @type LazyPluginSpec
return {
  "nvim-mini/mini-git",
  version = "*",
  opts = {},
  config = function(_, opts)
    require("mini.git").setup(opts)
  end,
  cmd = { "MiniGit", "Git" },
}
