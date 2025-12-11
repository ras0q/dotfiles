local default_adapter = {
  name = "copilot",
  model = "gpt-4.1",
}

---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  enabled = require("config.options").ai_enabled,
  dependencies = {
    "ravitemer/codecompanion-history.nvim",
    { "ravitemer/mcphub.nvim", opts = {} },
    "franco-ruggeri/codecompanion-spinner.nvim",
  },
  opts = {
    strategies = {
      chat = {
        adapter = default_adapter,
        roles = {
          llm = function(adapter)
            local model = (adapter and adapter.model) and adapter.model.name or "unknown"
            return "CodeCompanion (" .. adapter.formatted_name .. ", " .. model .. ")"
          end,
        },
        tools = {
          opts = {
            default_tools = {
              "full_stack_dev",
              "mcp",
            },
          },
        },
      },
      inline = {
        adapter = default_adapter,
      },
      agent = {
        adapter = default_adapter,
      },
    },
    display = {
      action_palette = {
        provider = "snacks",
      },
      chat = {
        window = {
          width = 0.3,
        },
      },
    },
    opts = {
      language = "Japanese",
    },
    extensions = {
      history = {
        title_generation_opts = default_adapter,
      },
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          show_result_in_chat = true, -- Show tool results directly in chat buffer
          format_tool = nil,          -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true,           -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true, -- Add MCP prompts as /slash commands
        },
      },
      spinner = {},
    },
  },
  keys = {
    { "<leader>an", "<cmd>CodeCompanionChat<cr>",        mode = { "n", "v" },             desc = "CodeCompanion - new" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>",            mode = { "n", "v" },             desc = "CodeCompanion - inline" },
    { "<leader>at", "<cmd>CodeCompanionChat toggle<cr>", desc = "CodeCompanion - toggle" },
    { "<leader>ap", "<cmd>CodeCompanionAction<cr>",      desc = "CodeCompanion - palette" },
    { "<leader>ac", "<cmd>CodeCompanionCmd<cr>",         desc = "CodeCompanion - command" },
  },
}
