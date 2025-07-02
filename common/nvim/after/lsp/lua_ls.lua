local plugins = require("lazy.core.config").plugins

return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      },
      runtime = {
        version = "LuaJIT",
        pathStrict = true,
        path = { "?.lua", "?/init.lua" },
      },
      workspace = {
        -- checkThirdParty = false,
        library = {
          vim.fn.stdpath("config") .. "/lua",
          vim.env.VIMRUNTIME .. "/lua",
          plugins["snacks.nvim"].dir .. "/lua",
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
        }
      }
    }
  }

}
