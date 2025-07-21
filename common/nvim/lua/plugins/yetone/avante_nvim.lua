---@type LazyPluginSpec
return {
  "yetone/avante.nvim",
  enabled = require("config.options").ai_enabled,
  event = "BufReadPre",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = "copilot",
    providers = {
      copilot = {
        model = "gpt-4.1",
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
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
  },
  config = function(_, opts)
    require("avante").setup(opts)
    -- In light theme, visibility of the diff view is bad.
    -- https://github.com/yetone/avante.nvim/issues/2491
    vim.api.nvim_set_hl(0, "AvanteToBeDeletedWOStrikethrough", { link = "DiffDelete" })
  end,
  build = vim.fn.has("win32") == 1
      and "pwsh.exe -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource -false"
      or "make",
}
