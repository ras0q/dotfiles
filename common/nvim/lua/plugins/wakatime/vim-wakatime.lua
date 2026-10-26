--- @type LazyPluginSpec
return {
  "wakatime/vim-wakatime",
  cond = require("config.options").wakatime_enabled,
  event = "VeryLazy",
}
