return {
  "zbirenbaum/copilot.lua",
  enabled = require("config.options").ai_enabled,
  event = "VeryLazy",
  config = function()
    require("copilot").setup()
  end,
}
