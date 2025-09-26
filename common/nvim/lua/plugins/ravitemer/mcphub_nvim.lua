return {
  "ravitemer/mcphub.nvim",
  enabled = require("config.options").ai_enabled,
  event = "VeryLazy",
  opts = {
    extensions = {
      avante = {
        make_slash_commands = true,
      },
    },
  },
}
