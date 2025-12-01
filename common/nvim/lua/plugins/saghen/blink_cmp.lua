---@type LazyPluginSpec
return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdLineEnter" },
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = false,
    },
  },
  dependencies = { "rafamadriz/friendly-snippets" },
}
