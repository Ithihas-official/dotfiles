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
	local fb_actions = require("telescope._extensions.file_browser.actions")
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
				path = vim.loop.cwd(),
				cwd = vim.loop.cwd(),
				cwd_to_path = false,
				grouped = false,
				files = true,
				add_dirs = true,
				depth = 1,
				auto_depth = false,
				select_buffer = false,
				hidden = { file_browser = false, folder_browser = false },
				respect_gitignore = vim.fn.executable("fd") == 1,
				no_ignore = false,
				follow_symlinks = false,
				browse_files = require("telescope._extensions.file_browser.finders").browse_files,
				browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
				hide_parent_dir = false,
				collapse_dirs = false,
				prompt_path = false,
				quiet = false,
				dir_icon = "",
				dir_icon_hl = "Default",
				display_stat = { date = true, size = true, mode = true },
				hijack_netrw = false,
				use_fd = true,
				git_status = true,
				mappings = {
					["i"] = {
						["<A-c>"] = fb_actions.create,
						["<S-CR>"] = fb_actions.create_from_prompt,
						["<A-r>"] = fb_actions.rename,
						["<A-m>"] = fb_actions.move,
						["<A-y>"] = fb_actions.copy,
						["<A-d>"] = fb_actions.remove,
						["<C-o>"] = fb_actions.open,
						["<C-g>"] = fb_actions.goto_parent_dir,
						["<C-e>"] = fb_actions.goto_home_dir,
						["<C-w>"] = fb_actions.goto_cwd,
						["<C-t>"] = fb_actions.change_cwd,
						["<C-f>"] = fb_actions.toggle_browser,
						["<C-h>"] = fb_actions.toggle_hidden,
						["<C-s>"] = fb_actions.toggle_all,
						["<bs>"] = fb_actions.backspace,
					},
					["n"] = {
						["c"] = fb_actions.create,
						["r"] = fb_actions.rename,
						["m"] = fb_actions.move,
						["y"] = fb_actions.copy,
						["d"] = fb_actions.remove,
						["o"] = fb_actions.open,
						["g"] = fb_actions.goto_parent_dir,
						["e"] = fb_actions.goto_home_dir,
						["w"] = fb_actions.goto_cwd,
						["t"] = fb_actions.change_cwd,
						["f"] = fb_actions.toggle_browser,
						["h"] = fb_actions.toggle_hidden,
						["s"] = fb_actions.toggle_all,
					},
				},
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
	vim.keymap.set("n", "<leader>fb", function()
		require("telescope").extensions.file_browser.file_browser()
	end)
end

return M

-- Insert / Normal 	fb_actions 	Description
-- <A-c>/c 	create 	Create file/folder at current path (trailing path separator creates folder)
-- <S-CR> 	create_from_prompt 	Create and open file/folder from prompt (trailing path separator creates folder)
-- <A-r>/r 	rename 	Rename multi-selected files/folders
-- <A-m>/m 	move 	Move multi-selected files/folders to current path
-- <A-y>/y 	copy 	Copy (multi-)selected files/folders to current path
-- <A-d>/d 	remove 	Delete (multi-)selected files/folders
-- <C-o>/o 	open 	Open file/folder with default system application
-- <C-g>/g 	goto_parent_dir 	Go to parent directory
-- <C-e>/e 	goto_home_dir 	Go to home directory
-- <C-w>/w 	goto_cwd 	Go to current working directory (cwd)
-- <C-t>/t 	change_cwd 	Change nvim's cwd to selected folder/file(parent)
-- <C-f>/f 	toggle_browser 	Toggle between file and folder browser
-- <C-h>/h 	toggle_hidden 	Toggle hidden files/folders
-- <C-s>/s 	toggle_all 	Toggle all entries ignoring ./ and ../
-- <Tab> 	see telescope.nvim 	Toggle selection and move to next selection
-- <S-Tab> 	see telescope.nvim 	Toggle selection and move to prev selection
-- <bs>/ 	backspace 	With an empty prompt, goes to parent dir. Otherwise acts normally
