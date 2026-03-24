return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    float_opts = {
      border = "rounded",
    },
    highlights = {
      Normal = { link = "Normal" },
      NormalFloat = { link = "NormalFloat" },
      FloatBorder = { link = "FloatBorder" },
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- pre-spawn a terminal to speed up the first time it is opened
    local Terminal = require("toggleterm.terminal").Terminal
    local term1 = Terminal:new({ count = 1 })
    term1:spawn()
  end,
  keys = {
    { "<leader>T", "<cmd>ToggleTerm<cr>",                 desc = "ToggleTerm" },
    { "<leader>t", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm (float)" },
  },
}
