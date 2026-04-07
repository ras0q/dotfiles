--- @type LazyPluginSpec
return {
  "wakatime/vim-wakatime",
  enabled = require("config.options").wakatime_enabled,
  event = "VeryLazy",
}
