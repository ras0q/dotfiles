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
    web_search_engine = {
      provider = os.getenv("TAVILY_API_KEY") ~= "" and "tavily" or ""
    },
    -- system_prompt as function ensures LLM always has latest MCP server state
    -- This is evaluated for every message, even in existing chats
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
      return { require("mcphub.extensions.avante").mcp_tool() }
    end,
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
