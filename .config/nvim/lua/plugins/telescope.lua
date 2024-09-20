local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },

		"nvim-telescope/telescope-file-browser.nvim",
	},
	lazy = true,
	cmd = "Telescope",
}

M.config = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "TelescopeResults",
		callback = function(ctx)
			vim.api.nvim_buf_call(ctx.buf, function()
				vim.fn.matchadd("TelescopeParent", "\t\t.*$")
				vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
			end)
		end,
	})

	local icons = require("user.icons")
	local actions = require("telescope.actions")

	local function filenameFirst(_, path)
		local tail = vim.fs.basename(path)
		local parent = vim.fs.dirname(path)
		if parent == "." then
			return tail
		end
		return string.format("%s\t\t%s", tail, parent)
	end

	require("telescope").setup({
		defaults = {
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.Forward .. "  ",
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
			path_display = { "smart" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" },
			sorting_strategy = nil,
			layout_strategy = nil,
			layout_config = {},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				-- "--hidden",
				"--glob=!.git/",
			},

			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
				n = {
					["<esc>"] = actions.close,
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["q"] = actions.close,
				},
			},
		},
		pickers = {
			live_grep = {
				theme = "dropdown",
			},

			grep_string = {
				theme = "dropdown",
			},

			find_files = {
				theme = "dropdown",
				previewer = false,
				path_display = filenameFirst,
			},

			buffers = {
				theme = "dropdown",
				previewer = false,
				initial_mode = "normal",
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["dd"] = actions.delete_buffer,
					},
				},
			},

			planets = {
				show_pluto = true,
				show_moon = true,
			},

			colorscheme = {
				enable_preview = true,
			},

			lsp_references = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_definitions = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_declarations = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_implementations = {
				theme = "dropdown",
				initial_mode = "normal",
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},

			file_browser = {
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				hidden = true,
			},
		},
	})

	require("telescope").load_extension("file_browser")

	local opts = { noremap = true, silent = true }
	local tl_builtin = require("telescope.builtin")

	vim.keymap.set("n", "<leader>ff", tl_builtin.find_files, opts)
	vim.keymap.set("n", "<leader>fg", tl_builtin.live_grep, opts)
	vim.keymap.set("n", "<space><space>", tl_builtin.oldfiles, opts)
	vim.keymap.set("n", "<leader>fh", tl_builtin.help_tags, opts)
	vim.api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser<CR>", opts)
end

return M
