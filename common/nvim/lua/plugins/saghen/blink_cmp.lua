---@type LazyPluginSpec
return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdLineEnter" },
  opts = {
    keymap = { preset = "enter" },
  },
  dependencies = { "rafamadriz/friendly-snippets" },
}
