---@type LazyPluginSpec
return {
  "mason-org/mason.nvim",
  build = ":MasonUpdate",
  cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
  opts = {
    ui = {
      border = "rounded",
    },
  },
}
