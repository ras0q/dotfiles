---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  branch = "main",
  build = ":TSUpdate",
  config = function()
    if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
      return
    end

    local ts = require("nvim-treesitter")

    local ensure_installed = {
      "bash",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "regex",
      "yaml",
    }
    ts.install(ensure_installed)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        local ft = vim.bo.filetype
        if not ft or ft == "" then return end

        local tsparsers = require("nvim-treesitter.parsers")
        if not tsparsers[ft] then
          return
        end

        local installed_parsers = ts.get_installed()
        for _, parser in ipairs(installed_parsers) do
          if parser == ft then
            vim.treesitter.start()
            return
          end
        end

        vim.cmd("TSInstall " .. ft)
      end,
    })
  end,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      keys = {
        {
          "[c",
          function()
            require("treesitter-context").go_to_context(vim.v.count1)
          end,
          desc = "Go to context",
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
  },
}
