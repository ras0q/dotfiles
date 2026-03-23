---@type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    sections = {
      lualine_c = {
        { "filename", path = 4 },
      },
      lualine_x = {
        "filetype",
      },
    },
  },
}
