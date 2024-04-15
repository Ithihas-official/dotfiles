local M = {

	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { {
		"nvim-tree/nvim-web-devicons",
	} },
}

M.config = function()
	require("dashboard").setup({
		theme = "hyper",
		config = {
			week_header = {
				enable = true,
			},
			shortcut = {
				{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
				{
					icon = " ",
					icon_hl = "@variable",
					desc = "Find Files",
					group = "Label",
					action = "Telescope find_files",
					key = "f",
				},
				{
					desc = "  File Browser",
					group = "DiagnosticHint",
					action = "Telescope file_browser",
					key = "b",
				},
				{
					desc = " Projects",
					group = "Number",
					action = "Telescope projects",
					key = "p",
				},
			},
		},
	})
end

return M
