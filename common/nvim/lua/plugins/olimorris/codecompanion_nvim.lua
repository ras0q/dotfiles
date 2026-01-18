local default_adapter = {
  name = "copilot",
  model = "gpt-4.1",
}

---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  enabled = require("config.options").ai_enabled,
  dependencies = {
    "ras0q/codecompanion-wakatime.nvim",
    "ravitemer/codecompanion-history.nvim",
    {
      "ravitemer/mcphub.nvim",
      opts = {
        ui = {
          window = { border = "rounded" },
        },
      },
    },
  },
  opts = {
    interactions = {
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
            auto_submit_errors = true,
            auto_submit_success = true,
            default_tools = {
              -- NOTE: Following tools are also useful, but disabled by default to reduce the total number of tools.
              -- - @fetch_webpage
              -- - @mcp__SERVERNAME
              "full_stack_dev",
            },
          },
          ["cmd_runner"] = {
            opts = {
              allowed_in_yolo_mode = true,
            },
          },
          ["create_file"] = {
            opts = {
              require_approval_before = false,
            },
          },
          ["read_file"] = {
            opts = {
              require_approval_before = false,
            },
          },
        },
        slash_commands = {
          help = {
            opts = {
              max_lines = 1024,
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
        show_header_separator = true,
      },
    },
    opts = {
      language = "Japanese",
    },
    rules = {
      default = {
        files = {
          "AGENTS.md",
          "~/.AGENTS.md",
        },
      },
    },
    prompt_library = {
      markdown = {
        dirs = {
          (vim.env.DOTFILES or "~") .. "/common/prompts",
        },
      },
    },
    extensions = {
      wakatime = {},
      history = {
        title_generation_opts = default_adapter,
        opts = {
          keymap = "gH",
        },
      },
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          make_tools = true,                   -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true,    -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = true, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true,          -- Show tool results directly in chat buffer
          format_tool = nil,                   -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true,                    -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true,          -- Add MCP prompts as /slash commands
        },
      },
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
