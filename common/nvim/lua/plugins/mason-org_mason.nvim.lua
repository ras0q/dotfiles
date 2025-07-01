return {
  "mason-org/mason.nvim",
  build = ":MasonUpdate",
  cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
  config = true,
}
