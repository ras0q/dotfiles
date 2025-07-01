return {
  "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  cmd = "Telescope",
  opts = {
    defaults = {
      sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
      },
    },
    extensions = {
      file_browser = {
        hijack_netrw = true,
      }
    }
  },
  keys = {
    { "<leader>t", "<cmd>Telescope<cr>", desc = "Open Telescope" },
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
    { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
    { "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
    { "<leader>b", "<cmd>Telescope file_browser<cr>", desc = "Telescope file browser" },
    { "<leader>c", "<cmd>Telescope commands<cr>", desc = "Telescope commands" },
  },
}
