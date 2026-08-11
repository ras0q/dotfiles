local function require_env(name)
  local value = vim.env[name]
  if value == nil or value == "" then
    error(("Missing required environment variable: %s"):format(name))
  end
  return value
end

--- @type vim.lsp.Config
return {
  settings = {
    baseUrl = require_env("GITLAB_URL"),
    token = require_env("GITLAB_TOKEN"),
    telemetry = {
      enabled = false,
    },
  },
  on_init = function() end,
  on_attach = function() end,
}
