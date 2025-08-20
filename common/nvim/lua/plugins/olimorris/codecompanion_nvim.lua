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
  event = "VeryLazy",
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
    },
    opts = {
      language = "Japanese",
    },
  },
}
