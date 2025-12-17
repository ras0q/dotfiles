---@type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = {
    "franco-ruggeri/codecompanion-lualine.nvim",
  },
  opts = {
    sections = {
      lualine_x = {
        "codecompanion",
      },
    },
  },
}
