return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup()
  end,
  keys = {
    { "<leader>t", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ToggleTerm" }
  }
}
