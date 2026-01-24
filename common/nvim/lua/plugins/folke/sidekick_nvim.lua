---@type LazyPluginSpec
return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  opts = {
    nes = {
      enabled = require("config.options").ai_nes_enabled,
    },
    cli = {
      win = {
        split = {
          width = 60,
        },
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if require("sidekick").nes_jump_or_apply() then
          return
        end

        if vim.lsp.inline_completion.get() then
          return
        end

        return "<Tab>" -- fallback to normal tab
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-.>",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
  },
}
