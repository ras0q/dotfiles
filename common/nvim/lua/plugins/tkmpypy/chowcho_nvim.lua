---@type LazyPluginSpec
return {
  "tkmpypy/chowcho.nvim",
  keys = {
    { "<leader>w", function() require("chowcho").run() end, desc = "Select window" }
  }
}
