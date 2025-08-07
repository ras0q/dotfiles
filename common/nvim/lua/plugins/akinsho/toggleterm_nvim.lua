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
    { "<leader>T", "<cmd>ToggleTerm<cr>",                 desc = "ToggleTerm" },
    { "<leader>t", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm (float)" },
  }
}
