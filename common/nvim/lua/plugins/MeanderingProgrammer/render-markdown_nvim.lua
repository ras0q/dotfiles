local file_types = { "markdown", "Avante", "codecompanion" }

---@type LazyPluginSpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = file_types,
    heading = { enabled = false },
  },
  ft = file_types,
}
