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
  },
  keys = {
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
    { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
    { "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
  },
}
