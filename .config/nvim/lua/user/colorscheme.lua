vim.cmd("colorscheme tokyonight")

require("lualine").setup({
	options = {

		theme = "auto",
	},
})

vim.cmd("autocmd VimEnter * hi NvimTreeNormal guibg=NONE")
vim.cmd("autocmd VimEnter * hi NvimTreeNormalNC guibg=NONE")
