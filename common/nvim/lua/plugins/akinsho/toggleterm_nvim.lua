return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = {
    "ToggleTerm",
  },
  opts = {
    float_opts = {
      border = "curved",
    }
  },
  keys = {
    { "<leader>t", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm (float)" },
  }
}
