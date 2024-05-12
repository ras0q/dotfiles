-- LSP: nvim-lspconfig
-- Formatter / Linter: none-ls.nvim
-- Package Manager: mason.nvim

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = {
			ui = { border = "single" },
		},
	},

	-- LSP
	{
		"williamboman/mason-lspconfig",
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"lua_ls",
				"bashls",
				"gopls",
				"jsonls",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		event = "LspAttach",
		config = function()
			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({})
				end,
			})
		end,
	},

	-- Formatter / Linter
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"stylua",
				"goimports",
				"golangci_lint",
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local builtins = require("null-ls.builtins")
			require("null-ls").setup({
				sources = {
					builtins.formatting.stylua,
					builtins.formatting.goimports,
					builtins.diagnostics.golangci_lint,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},
}
