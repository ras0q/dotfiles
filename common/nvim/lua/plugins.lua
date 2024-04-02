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
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      }
    },
    -- event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      telescope.setup {
        defaults = {
          layout_config = {
            prompt_position = "top",
            preview_width = 0.6
          },
          sorting_strategy = "ascending",
        },
        extensions = {
          file_browser = {
            hidden = { file_browser = true },
            display_stat = false,
            hijack_netrw = true,
          },
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          }
        }
      }

      telescope.load_extension("file_browser")
      vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", {})

      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", function()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        if vim.v.shell_error == 0 then
          builtin.git_files()
        else
          builtin.find_files({ hidden = true })
        end
      end, {})
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
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup()
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
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
        presets = {
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  }
})
