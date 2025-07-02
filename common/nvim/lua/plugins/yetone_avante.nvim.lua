return {
  "yetone/avante.nvim",
  enabled = require("config.options").ai_enabled,
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = "copilot",
    providers = {
      copilot = {
        model = "claude-3.7-sonnet",
      },
    },
    input = {
      provider = "snacks",
      provider_opts = {
        title = "Avante Input",
        icon = " ",
        placeholder = "Enter your API key...",
      }
    },
    windows = {
      ask = {
        floating = true,
        border = "rounded",
      }
    }
  },
  build = "make",
}
