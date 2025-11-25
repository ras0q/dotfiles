--- @type vim.lsp.Config
return {
  cmd = {
    "bunx",
    "--registry=https://gitlab.com/api/v4/packages/npm/",
    "@gitlab-org/gitlab-lsp",
    "--stdio",
  },
  settings = {
    baseUrl = vim.env.GITLAB_URL,
    token = vim.env.GITLAB_TOKEN,
    telemetry = {
      enabled = false,
    },
  },
  on_init = function() end,
  on_attach = function() end,
}
