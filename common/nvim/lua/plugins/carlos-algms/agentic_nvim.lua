---@type LazyPluginSpec
return {
  "carlos-algms/agentic.nvim",
  opts = function()
    return {
      provider = vim.fn.executable("codex-acp") == 1 and "codex-acp" or "copilot-acp",
    }
  end,
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
      "<leader>an",
      function() require("agentic").new_session() end,
      desc = "New Agentic Session",
    },
    {
      "<leader>at",
      function() require("agentic").toggle() end,
      desc = "Toggle Agentic Chat",
    },
    {
      "<leader>ac",
      function() require("agentic").add_selection_or_file_to_context() end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic to Context",
    },
    {
      "<leader>as",
      function() require("agentic").restore_session() end,
      desc = "Agentic Restore session",
      silent = true,
    },
  },
}
