require("toggleterm").setup({
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<space>\]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
	persist_size = true,
	persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
	direction = "float",
	shell = "/bin/zsh",
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = "curved",
	},
})
