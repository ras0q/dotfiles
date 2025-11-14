--- @type vim.lsp.Config
return {
  autostart = true,
  name = "gitlab_lsp",
  cmd = { "bunx", "--registry=https://gitlab.com/api/v4/packages/npm/", "@gitlab-org/gitlab-lsp", "--stdio" },
  root_markers = { ".git" },
  init_options = {
    editorInfo = {
      name = "Neovim",
      version = tostring(vim.version()),
    },
    editorPluginInfo = {
      name = "Neovim",
      version = tostring(vim.version()),
    },
  },
  docs = {
    description = "GitLab Language Server",
  },
  settings = {
    baseUrl = vim.env.GITLAB_URL,
    token = vim.env.GITLAB_TOKEN,
    telemetry = {
      enabled = false,
    },
  },
}
