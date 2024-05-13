-- Finder: telescope.nvim

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-file-browser.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_config = {
					prompt_position = "top",
					preview_width = 0.6,
				},
				sorting_strategy = "ascending",
				mappings = {
					n = {
						["q"] = actions.close,
						["ZZ"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--hidden", "--exclude", "**/.git/*" },
				},
			},
			extensions = {
				file_browser = {
					grouped = true, -- directories, then files
					auto_depth = true,
					hidden = { file_browser = true },
					display_stat = false,
					hijack_netrw = true,
				},
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})

		require("telescope").load_extension("file_browser")
		vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", {})
	end,
}
