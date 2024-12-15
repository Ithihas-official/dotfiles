vim.cmd("colorscheme catppuccin-latte")

require("lualine").setup({
	options = {

		theme = "auto",
	},
})

require("barbecue").setup({
	options = {
		theme = "auto",
	},
})
