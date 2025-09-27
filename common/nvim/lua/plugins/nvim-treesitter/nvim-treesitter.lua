---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    local ensure_installed = { "bash", "json", "jsonc", "markdown", "yaml", "regex" }
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

        vim.notify(
          "TreeSitter parser for " .. ft .. " is not installed\n:TSInstall " .. ft,
          "warn",
          { title = "nvim-treesitter" }
        )
      end,
    })
  end,
}
