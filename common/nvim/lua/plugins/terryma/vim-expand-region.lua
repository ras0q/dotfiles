---@type LazyPluginSpec
return {
  "terryma/vim-expand-region",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "v", "<Plug>(expand_region_expand)", mode = "v", desc = "Expand Region" },
    { "V", "<Plug>(expand_region_shrink)", mode = "v", desc = "Shrink Region" },
  },
}
