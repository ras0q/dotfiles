---@type LazyPluginSpec
return {
  "WilliamHsieh/overlook.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  keys = {
    { "gpd",    function() require("overlook.api").peek_definition() end,         desc = "Overlook: Peek definition" },
    { "gpc",    function() require("overlook.api").close_all() end,               desc = "Overlook: Close all popup" },
    { "gpu",    function() require("overlook.api").restore_popup() end,           desc = "Overlook: Restore popup" },
    { "gp<CR>", function() require("overlook.api").open_in_original_window() end, desc = "Overlook: Open in original window" },
  },
}
