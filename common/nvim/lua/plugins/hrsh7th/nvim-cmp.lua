---@type LazyPluginSpec
return {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  opts = function()
    local cmp = require("cmp")
    return {
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      })
    }
  end
}
