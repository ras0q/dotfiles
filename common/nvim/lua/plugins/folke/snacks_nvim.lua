local list_repos = {
  finder = "proc",
  cmd = "ghq",
  args = { "list", "--full-path" },
  transform = function(item)
    item.file = item.text
    item.dir = true
  end,
  confirm = function(picker, item)
    picker:close()
    vim.cmd("cd " .. item.text)
  end,
}

local is_git_item = function(item, git_nodes)
  return vim.iter(git_nodes):any(function(node)
    if node.dir_status then
      return vim.fs.relpath(node.path, item.file) ~= nil
    end
    return vim.fs.relpath(item.file, node.path) ~= nil
  end)
end

--- @type LazyPluginSpec
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  enabled = vim.g.vscode == nil,
  ---@type snacks.Config
  opts = {
    indent = {
      enabled = true,
      scope = { char = "╎" },
    },
    lazygit = {
      config = {
        os = {
          edit =
          '[ -z "\"$NVIM\"" ] && (nvim -- {{filename}}) || (nvim --server "\"$NVIM\"" --remote-send "\"q\"" && nvim --server "\"$NVIM\"" --remote {{filename}})',
        },
      },
    },
    notifier = {
      enabled = true,
      timeout = 5000,
    },
    picker = {
      enabled = true,
      hidden = true,
      sources = {
        explorer = {
          finder = function(opts, ctx)
            local Tree = require("snacks.explorer.tree")
            local git_nodes = {}
            Tree:walk(Tree:find(ctx.picker:cwd()), function(node)
              if node.status then
                table.insert(git_nodes, node)
              end
            end)
            ctx.picker.git_nodes = git_nodes
            return require("snacks.picker.source.explorer").explorer(opts, ctx)
          end,
          -- Config
          transform = function(item, ctx)
            if ctx.picker.opts.only_changed then
              return is_git_item(item, ctx.picker.git_nodes)
            end
          end,
          only_changed = false,
          toggles = {
            only_changed = "S",
          },
          win = {
            list = {
              keys = {
                ["S"] = "toggle_only_changed",
              },
            },
          },
        },
      },
    },
    quickfile = { enabled = true },
    terminal = {
      win = {
        border = "rounded",
      },
    },
    zen = {
      enabled = true,
      toggles = {
        dim = false,
      },
    },
  },
  keys = {
    { "<leader>b", function() Snacks.picker.buffers({ hidden = true }) end,                               desc = "Buffers" },
    { "<leader>e", function() Snacks.explorer() end,                                                      desc = "Toggle explorer" },
    { "<leader>c", function() Snacks.picker.files({ hidden = true, cwd = vim.fn.stdpath("config") }) end, desc = "Config" },
    { "<leader>f", function() Snacks.picker.files({ hidden = true }) end,                                 desc = "Find Files" },
    { "<leader>F", function() Snacks.picker(list_repos) end,                                              desc = "List Repositories" },
    { "<leader>g", function() Snacks.picker.grep({ hidden = true }) end,                                  desc = "Live Grep" },
    { "<leader>l", function() Snacks.lazygit() end,                                                       desc = "LazyGit" },
    { "<leader>p", function() Snacks.picker.pickers() end,                                                desc = "List Pickers" },
    { "<leader>r", function() Snacks.picker.recent() end,                                                 desc = "List Recent files" },
    { "<leader>z", function() Snacks.zen({ width = 100 }) end,                                            desc = "Zen Mode" },
  },
}
