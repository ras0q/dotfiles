local enabled = { enabled = true }

-- for avante.nvim's input provider
return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    picker = enabled,
  }
}
