---@type LazyPluginSpec
return {
  "mason-org/mason.nvim",
  build = ":MasonUpdate",
  cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
  config = true,
  opts = {
    ui = {
      border = "rounded",
    },
  },
}
