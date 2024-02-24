local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function() vim.cmd.colorscheme "catppuccin-latte" end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "nvim-treesitter.install".prefer_git = false
      require "nvim-treesitter.configs".setup {
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
          require("telescope").load_extension("file_browser")
        end,
      },
    },
    config = function()
      require("telescope").setup {
        pickers = {
          find_files = {
            -- show dotfiles
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" }
          }
        }
      }
      local builtin = require("telescope.builtin")
      -- find files
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      -- search for a string
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    end,
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.completion").setup()
      require("mini.cursorword").setup()
      require("mini.indentscope").setup()
      require("mini.pairs").setup()
      require("mini.statusline").setup()
      require("mini.trailspace").setup()
    end,
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  }
})
