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
    lazy = false,
    priority = 1000,
    config = function() vim.cmd.colorscheme "catppuccin-latte" end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false,
    event = "VeryLazy",
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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    -- event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup {
        defaults = {
          layout_config = {
            prompt_position = "top",
            preview_width = 0.6
          },
          sorting_strategy = "ascending",
          mappings = {
            n = {
              ["q"] = actions.close,
              ["ZZ"] = actions.close,
            }
          }
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--hidden", "--exclude", "**/.git/*", }
          }
        },
        extensions = {
          file_browser = {
            grouped = true, -- directories, then files
            auto_depth = true,
            hidden = { file_browser = true },
            display_stat = false,
            hijack_netrw = true,
          },
        }
      }

      telescope.load_extension("file_browser")
      vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", {})

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    end,
  },
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
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
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("mason").setup({
        ui = { border = "single" }
      })
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "bashls", "gopls", "jsonls" }
      })
      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets = {
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    build = ":Copilot enable"
  },
})
