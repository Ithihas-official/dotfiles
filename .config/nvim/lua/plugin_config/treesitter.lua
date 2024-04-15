require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"html",
		"css",
		"rust",
		"javascript",
		"scss",
		"json",
		"typescript",
		"markdown",
		"markdown_inline",
		"bash",
		"python",
	},

	sync_install = false,
	auto_install = true,

	highlight = {
		-- `false` will disable the whole extension
		enable = true,
	},
})
