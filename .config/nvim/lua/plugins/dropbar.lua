local M = {
	"Bekaboo/dropbar.nvim",
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	config = function()
		vim.ui.select = require("dropbar.utils.menu").select
		local dropbar_api = require("dropbar.api")
		vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
		vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
		vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		vim.ui.select = require("dropbar.utils.menu").select
	end,
}

M.opts = {
	attach_events = {
		"OptionSet",
		"BufWinEnter",
		"BufWritePost",
	},
	update_events = {
		win = {
			"CursorMoved",
			"WinEnter",
			"WinResized",
		},
	},
}

return M