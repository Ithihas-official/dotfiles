require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
	},
	pickers = {
		live_grep = {
			hidden = true,
		},
		find_files = {
			hidden = false,
			no_ignore = true,
		},

		help_tags = {
			hidden = false,
			no_ignore = true,
		},

		oldfiles = {
			hidden = false,
			no_ignore = true,
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<space><space>", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
