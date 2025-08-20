local copilot_adapter = function()
  return require("codecompanion.adapters").extend("copilot", {
    schema = {
      model = {
        default = "gpt-4.1",
      },
    },
  })
end

---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  enabled = require("config.options").ai_enabled,
  event = "BufReadPre",
  opts = {
    strategies = {
      chat = {
        adapter = copilot_adapter,
        roles = {
          llm = function(adapter)
            return "CodeCompanion (" .. adapter.formatted_name .. ", " .. adapter.model.name .. ")"
          end,
        },
      },
      inline = {
        adapter = copilot_adapter,
      },
      agent = {
        adapter = copilot_adapter,
      },
    },
    display = {
      action_palette = {
        provider = "snacks",
      },
      chat = {
        show_settings = true,
        window = {
          width = 0.3,
        },
      },
    },
    opts = {
      language = "Japanese",
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          make_tools = true,                    -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true,     -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true,           -- Show tool results directly in chat buffer
          format_tool = nil,                    -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true,                     -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true,           -- Add MCP prompts as /slash commands
        },
      },
    },
  },
  keys = {
    { "<leader>an", "<cmd>CodeCompanionChat<cr>",        mode = { "n", "v" },             desc = "CodeCompanion - new" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>",            mode = { "n", "v" },             desc = "CodeCompanion - inline" },
    { "<leader>at", "<cmd>CodeCompanionChat toggle<cr>", desc = "CodeCompanion - toggle" },
    { "<leader>ap", "<cmd>CodeCompanionAction<cr>",      desc = "CodeCompanion - palette" },
  },
}
