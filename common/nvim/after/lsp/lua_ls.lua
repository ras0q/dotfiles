local plugins = require("lazy.core.config").plugins

local function get_plugin_libs(keys)
  local lib = {}
  for _, k in ipairs(keys) do
    local p = plugins[k]
    if p and p.dir then
      table.insert(lib, p.dir .. "/lua")
    end
  end

  return lib
end

---@type vim.lsp.Config
return {
  on_init = function(client)
    if client.root_dir == vim.env.DOTFILES then
      ---@diagnostic disable: undefined-field
      client.config.settings.Lua.workspace.library = vim.list_extend(
        client.config.settings.Lua.workspace.library,
        get_plugin_libs({ "lazy.nvim", "snacks.nvim", "wezterm-types" })
      )
    end
  end,
  ---@diagnostic enable: undefined-field
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
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
        },
      },
    },
  },
}
