local custom_highlights = {
  -- https://github.com/yetone/avante.nvim/issues/1797
  AvanteSidebarWinSeparator        = "AvanteSidebarWinHorizontalSeparator",
  -- https://github.com/yetone/avante.nvim/issues/2491
  AvanteToBeDeletedWOStrikethrough = "DiffDelete",
}

---@type LazyPluginSpec
return {
  "yetone/avante.nvim",
  -- enabled = require("config.options").ai_enabled,
  enabled = false,
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
      },
    },
    windows = {
      input = {
        height = 10,
      },
    },
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
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
    for avante_hl, default_hl in pairs(custom_highlights) do
      vim.api.nvim_set_hl(0, avante_hl, { link = default_hl })
    end
  end,
  build = vim.fn.has("win32") == 1
      and "pwsh.exe -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource -false"
      or "make",
}
