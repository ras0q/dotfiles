local file_types = { "markdown", "Avante", "codecompanion" }

---@type LazyPluginSpec
return {
  -- Make sure to set this up properly if you have lazy=true
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = false,
  opts = {
    file_types = file_types,
  },
  ft = file_types,
}
