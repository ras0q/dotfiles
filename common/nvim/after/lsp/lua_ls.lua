local plugins = require("lazy.core.config").plugins

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        defaultConfig = {
          quote_style = "double",
          call_arg_parentheses = "always",
          trailing_table_separator = "smart",
        },
      },
      runtime = {
        version = "LuaJIT",
        pathStrict = true,
        path = { "?.lua", "?/init.lua" },
      },
      workspace = {
        library = {
          vim.loop.cwd(),
          vim.fn.stdpath("config") .. "/lua",
          vim.env.VIMRUNTIME .. "/lua",
          plugins["lazy.nvim"].dir .. "/lua",
          plugins["snacks.nvim"].dir .. "/lua",
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
        },
      },
    },
  },
}
