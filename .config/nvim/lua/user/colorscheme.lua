vim.cmd("colorscheme catppuccin-macchiato")

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
