--- @type vim.lsp.Config
return {
  settings = {
    yaml = {
      customTags = {
        -- GitLab CI
        "!reference",
        "!reference sequence",
      },
    },
  },
}
