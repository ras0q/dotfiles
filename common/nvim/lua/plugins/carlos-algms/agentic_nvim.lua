---@type LazyPluginSpec
return {
  "carlos-algms/agentic.nvim",
  event = "VeryLazy",
  opts = {
    provider = "codex-acp",
  },
  config = function(_, opts)
    require("agentic").setup(opts)

    vim.treesitter.language.register("markdown", "AgenticChat")
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "AgenticChat",
      callback = function()
        vim.opt_local.syntax = "markdown"
      end,
    })

    local hl = vim.api.nvim_set_hl
    hl(0, "AgenticStatusPending", { link = "WarningMsg" })
    hl(0, "AgenticStatusCompleted", { link = "OkMsg" })
    hl(0, "AgenticStatusFailed", { link = "ErrorMsg" })
  end,
  keys = {
    {
      "<C-\\>",
      function() require("agentic").toggle() end,
      mode = { "n", "v", "i" },
      desc = "Toggle Agentic Chat",
    },
    {
      "<C-'>",
      function() require("agentic").add_selection_or_file_to_context() end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic to Context",
    },
    {
      "<C-,>",
      function() require("agentic").new_session() end,
      mode = { "n", "v", "i" },
      desc = "New Agentic Session",
    },
    {
      "<A-i>r", -- ai Restore
      function()
        require("agentic").restore_session()
      end,
      desc = "Agentic Restore session",
      silent = true,
      mode = { "n", "v", "i" },
    },
  },
}
