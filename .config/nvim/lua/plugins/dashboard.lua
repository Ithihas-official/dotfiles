local M = {

	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { {
		"nvim-tree/nvim-web-devicons",
	} },
}

M.config = function()
	require("dashboard").setup({
		theme = "hyper", --  theme is doom and hyper default is hyper
		config = {
			week_header = {
				enable = true,
			},
			shortcut = {
				{ desc = "󰊳 Update", group = "@property", action = "Lazy sync", key = "u" },
				{
					icon = " ",
					icon_hl = "@variable",
					desc = "Files",
					group = "Label",
					action = "Telescope find_files",
					key = "f",
				},
				{
					desc = " File Browser",
					group = "FileBrowser",
					action = "Telescope file_browser",
					key = "h",
				},
				{
					desc = " Projects",
					group = "ProjectManager",
					action = "Telescope projects",
					key = "p",
				},
			},
		},
	})
end

return M
