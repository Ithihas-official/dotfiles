require("bufferline").setup({
	options = {
		themable = true,
		indicator = {
			icon = " ☍  ",
			style = "icon",
		},
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
			{
				filetype = "aerial",
				text = "Outline",
				text_align = "center",
				separator = true,
			},
		},
		separator_style = { "❱", "❱" },
	},
})
