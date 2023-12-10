return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.completion").setup()
    require("mini.cursorword").setup()
    require("mini.indentscope").setup()
    require("mini.pairs").setup()
    require("mini.statusline").setup()
    require("mini.trailspace").setup()
  end,
}
