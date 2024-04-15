local M = {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
}

function M.config()
	local function my_on_attach(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		api.config.mappings.default_on_attach(bufnr)

		vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
		vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
		vim.keymap.del("n", "<C-k>", { buffer = bufnr })
		vim.keymap.set("n", "<S-k>", api.node.open.preview, opts("Open Preview"))
	end

	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- set termguicolors to enable highlight groups
	vim.opt.termguicolors = true
	-- vim.keymap.set("n", "<leader>E", ":NvimTreeToggle<CR>")
	vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", {})
	-- vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)
	require("nvim-tree").setup({

		on_attach = my_on_attach,
		hijack_netrw = true,
		auto_reload_on_write = true,
		reload_on_bufenter = true,
		view = {
			centralize_selection = true,
			width = 35,
			side = "right",
		},
		renderer = {
			indent_width = 0,
			group_empty = true,
			highlight_git = true,
			highlight_opened_files = "all",
			root_folder_label = function(path)
				return "| " .. vim.fn.fnamemodify(path, ":t")
			end,
			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					bottom = "─",
					none = " ",
				},
			},
			icons = {
				webdev_colors = true,
				git_placement = "after",
			},
		},
		modified = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = true,
		},
		git = {
			enable = true,
			ignore = true,
			show_on_dirs = true,
			show_on_open_dirs = true,
			timeout = 400,
		},
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
	})
end
return M
