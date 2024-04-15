local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"AndreM222/copilot-lualine",
		"nvim-tree/nvim-web-devicons",
	},
}

M.config = function()
	local icons = require("user.icons")
	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand("%:p:h")
			local gitdir = vim.fn.finddir(".git", filepath .. ";")
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
	}

	local function title()
		return [[-‘๑’-]]
	end

	local function lspGen()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end

	require("lualine").setup({
		options = {
			icons_enabled = true,
			disabled_filetypes = { "NvimTree", "aerial", "Telescope" },
			-- component_separators = { left = "（", right = "）" },
			-- section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{
					title,
					separator = { left = "", right = "" },
				},
			},
			lualine_b = {

				{
					"filename",
					cond = conditions.buffer_not_empty,

					separator = { right = "" },
				},

				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " " },
					separator = { right = "" },
				},
			},
			lualine_c = {

				{
					"aerial",
					sep = " ) ",

					-- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
					-- be used in order to render only current symbol.
					depth = nil,

					-- When 'dense' mode is on, icons are not rendered near their symbols. Only
					-- a single icon that represents the kind of current symbol is rendered at
					-- the beginning of status line.
					dense = true,

					-- The separator to be used to separate symbols in dense mode.
					dense_sep = ".",

					-- Color the symbol icons.
					colored = true,
				},
				{
					"branch",
				},
				{
					"diff",
					colored = false,
					symbols = {
						added = icons.git.LineAdded,
						modified = icons.git.LineModified,
						removed = icons.git.LineRemoved,
					}, -- Changes the symbols used by the diff.
					separator = { right = "）" },
				},
			},
			lualine_x = {

				{
					lspGen,
					icon = " LSP:",
					separator = { left = "（" },
				},
			},

			lualine_y = {
				{
					"searchcount",
					separator = { left = "" },
				},
				{
					"location",
					separator = { left = "" },
				},
				{
					"progress",
					separator = { left = "" },
				},
			},
			lualine_z = {

				{
					"filetype",
					separator = { left = "", right = "" },
				},
			},
		},
	})
end

return M
