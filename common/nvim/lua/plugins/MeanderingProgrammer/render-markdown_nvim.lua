local file_types = { "markdown", "Avante", "codecompanion", "AgenticChat" }

---@type LazyPluginSpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    enabled = false,
    file_types = file_types,
    heading = { enabled = false },
  },
  ft = file_types,
}
