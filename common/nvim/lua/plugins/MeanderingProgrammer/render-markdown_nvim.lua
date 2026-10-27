local file_types = { "markdown", "Avante", "codecompanion", "AgenticChat" }

---@type LazyPluginSpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = file_types,
    heading = {
      width = "full",
      icons = {},
    },
    code = {
      width = "block",
    },
    anti_conceal = {
      enabled = false,
    },
  },
  ft = file_types,
}
