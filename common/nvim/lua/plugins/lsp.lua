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
		"neovim/nvim-lspconfig",
		lazy = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
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
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
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
		"nvimtools/none-ls.nvim",
		lazy = true,
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
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"stylua",
				"goimports",
				"golangci_lint",
			},
		},
	},
}
