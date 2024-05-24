vim.cmd("colorscheme tokyonight")

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
