---@type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = {
    "franco-ruggeri/codecompanion-lualine.nvim",
  },
  opts = {
    sections = {
      lualine_c = {
        { "filename", path = 4 },
      },
      lualine_x = {
        "codecompanion",
        "filetype",
      },
    },
  },
}
