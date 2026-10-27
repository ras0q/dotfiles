---@type LazyPluginSpec
return {
  "carlos-algms/agentic.nvim",
  opts = function()
    local session_cwds = {}

    local function notify(session_key, message)
      local cwd = vim.fn.fnamemodify(session_cwds[session_key] or vim.fn.getcwd(), ":t")
      local title = ("Agentic #%s (%s)"):format(session_key, cwd):gsub("[%c;]", " ")
      message = vim.fn.strcharpart(message:gsub("[%c;]", " "):gsub("%s+", " "), 0, 200)
      vim.api.nvim_ui_send(("\027]777;notify;%s;%s\027\\\007"):format(title, message))
    end

    return {
      provider = vim.fn.executable("cursor-agent") == 1 and "cursor-acp" or "codex-acp",
      hooks = {
        on_prompt_submit = function(data)
          session_cwds[data.session_key] = vim.fn.getcwd()
        end,
        on_response_complete = function(data)
          local message = data.success and "Response complete" or "Response failed"
          if data.error then
            message = message .. ": " .. (data.error.message or vim.inspect(data.error))
          end
          notify(data.session_key, message)
        end,
        on_request_permission = function(data)
          local tool = data.request.toolCall
          notify(data.session_key, "Permission requested: " .. (tool.title or tool.kind or "action"))
        end,
      },
    }
  end,
  config = function(_, opts)
    require("agentic").setup(opts)

    vim.treesitter.language.register("markdown", "AgenticChat")
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "AgenticChat",
      callback = function()
        vim.opt_local.syntax = "markdown"
        vim.bo.filetype = "markdown"
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
