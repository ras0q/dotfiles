---@type LazyPluginSpec
return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  opts = {
    diff = {
      layout = "inline",
      gutter_signs = { insert_text = "＋", delete_text = "－", highlight_numbers = true },
      compute_moves = true,
    },
    explorer = {
      view_mode = "tree",
      line_stats = {
        enabled = true,
      },
    },
  },
}
