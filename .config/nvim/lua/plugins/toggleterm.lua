-- require("toggleterm").setup({
-- 	-- size can be a number or function which is passed the current terminal
-- 	size = function(term)
-- 		if term.direction == "horizontal" then
-- 			return 15
-- 		elseif term.direction == "vertical" then
-- 			return vim.o.columns * 0.4
-- 		end
-- 	end,
	-- open_mapping = [[<space>\]],
-- 	hide_numbers = true, -- hide the number column in toggleterm buffers
-- 	autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
-- 	persist_size = true,
-- 	persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
-- 	direction = "float",
-- 	shell = "/bin/zsh",
-- 	float_opts = {
-- 		-- The border key is *almost* the same as 'nvim_open_win'
-- 		-- see :h nvim_open_win for details on borders however
-- 		-- the 'curved' border is a custom border type
-- 		-- not natively supported but implemented in this plugin.
-- 		border = "curved",
-- 	},
-- })

local M = {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
}

function M.config()
	local execs = {
		{ nil, "<C-1>", "Horizontal Terminal", "horizontal", 0.3 },
		{ nil, "<C-2>", "Vertical Terminal", "vertical", 0.4 },
		{ nil, "<C-3>", "Float Terminal", "float", nil },
	}

	local function get_buf_size()
		local cbuf = vim.api.nvim_get_current_buf()
		local bufinfo = vim.tbl_filter(function(buf)
			return buf.bufnr == cbuf
		end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
		if bufinfo == nil then
			return { width = -1, height = -1 }
		end
		return { width = bufinfo.width, height = bufinfo.height }
	end

	local function get_dynamic_terminal_size(direction, size)
		size = size
		if direction ~= "float" and tostring(size):find(".", 1, true) then
			size = math.min(size, 1.0)
			local buf_sizes = get_buf_size()
			local buf_size = direction == "horizontal" and buf_sizes.height or buf_sizes.width
			return buf_size * size
		else
			return size
		end
	end

	local exec_toggle = function(opts)
		local Terminal = require("toggleterm.terminal").Terminal
		local term = Terminal:new({ cmd = opts.cmd, count = opts.count, direction = opts.direction })
		term:toggle(opts.size, opts.direction)
	end

	local add_exec = function(opts)
		local binary = opts.cmd:match("(%S+)")
		if vim.fn.executable(binary) ~= 1 then
			vim.notify("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
			return
		end

		vim.keymap.set({ "n", "t" }, opts.keymap, function()
			exec_toggle({ cmd = opts.cmd, count = opts.count, direction = opts.direction, size = opts.size() })
		end, { desc = opts.label, noremap = true, silent = true })
	end

	for i, exec in pairs(execs) do
		local direction = exec[4]

		local opts = {
			cmd = exec[1] or vim.o.shell,
			keymap = exec[2],
			label = exec[3],
			count = i + 100,
			direction = direction,
			size = function()
				return get_dynamic_terminal_size(direction, exec[5])
			end,
		}

		add_exec(opts)
	end

	require("toggleterm").setup({
		size = 20,
		open_mapping = [[<space>\]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		persist_size = false,
		direction = "float",
		close_on_exit = true, -- close the terminal window when the process exits
		shell = nil, -- change the default shell
		float_opts = {
			border = "rounded",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
		winbar = {
			enabled = true,
			name_formatter = function(term) --  term: Terminal
				return term.count
			end,
		},
	})
	vim.cmd([[
  augroup terminal_setup | au!
  autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
  autocmd TermEnter * startinsert!
  augroup end
  ]])

	vim.api.nvim_create_autocmd({ "TermEnter" }, {
		pattern = { "*" },
		callback = function()
			vim.cmd("startinsert")
			_G.set_terminal_keymaps()
		end,
	})

	local opts = { noremap = true, silent = true }
	function _G.set_terminal_keymaps()
		vim.api.nvim_buf_set_keymap(0, "t", "<m-h>", [[<C-\><C-n><C-W>h]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<m-j>", [[<C-\><C-n><C-W>j]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<m-k>", [[<C-\><C-n><C-W>k]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<m-l>", [[<C-\><C-n><C-W>l]], opts)
	end

	-- abstract to function
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		float_opts = {
			border = "rounded",
		},
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
		-- function to run on closing the terminal
		on_close = function(term)
			vim.cmd("startinsert!")
		end,
	})

	local bun_outdated = Terminal:new({
		cmd = "bunx npm-check-updates@latest -ui --format group --packageManager bun",
		dir = "git_dir",
		direction = "float",
		float_opts = {
			border = "rounded",
		},
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
		-- function to run on closing the terminal
		on_close = function(term)
			vim.cmd("startinsert!")
		end,
	})

	local cargo_run = Terminal:new({
		cmd = "cargo run -q",
		dir = "git_dir",
		direction = "float",
		float_opts = {
			border = "rounded",
		},
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
		-- function to run on closing the terminal
		on_close = function(term)
			vim.cmd("startinsert!")
		end,
	})

	function _lazygit_toggle()
		lazygit:toggle()
	end

	function _bun_outdated()
		bun_outdated:toggle()
	end

	function _cargo_run()
		cargo_run:toggle()
	end

	-- vim.api.nvim_set_keymap("n", "<leader>gz", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
	-- vim.api.nvim_set_keymap("n", "<leader>co", "<cmd>lua _bun_outdated()<CR>", { noremap = true, silent = true })
	-- vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua _cargo_run()<CR>", { noremap = true, silent = true })
end

return M
