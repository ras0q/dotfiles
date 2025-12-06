--- @type vim.lsp.Config
return {
  on_init = function()
    local hlc = vim.api.nvim_get_hl(0, { name = "Comment" })
    vim.api.nvim_set_hl(0, "ComplHint", vim.tbl_extend("force", hlc, { underline = true }))
    local hlm = vim.api.nvim_get_hl(0, { name = "MoreMsg" })
    vim.api.nvim_set_hl(0, "ComplHintMore", vim.tbl_extend("force", hlm, { underline = true }))
  end,
}
