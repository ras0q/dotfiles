return {
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
}
