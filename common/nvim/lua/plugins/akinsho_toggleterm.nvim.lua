return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup()
  end,
  cmd = {
    "ToggleTerm",
  },
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ToggleTerm" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm (float)" },
  }
}
