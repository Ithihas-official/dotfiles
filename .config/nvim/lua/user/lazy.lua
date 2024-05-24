local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- THEMES
	{ "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- MARKDOWN PREVIEW
	{

		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- FILE MANAGER
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	-- STATUS LINE
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- FLOATING CMD LINE
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	-- CODE OUTLINE
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- LSP
	{
		"williamboman/mason.nvim",
	},
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason-lspconfig.nvim",
	},

	-- AUTO COMPLETE
	{
		"hrsh7th/nvim-cmp",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/cmp-path", -- Optional
	},
	{
		"saadparwaiz1/cmp_luasnip", -- Optional
	},
	{
		"hrsh7th/cmp-nvim-lua", -- Optional
	},

	-- SNIPPETS
	{
		"L3MON4D3/LuaSnip", -- Required
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{
		"rafamadriz/friendly-snippets", -- Optional
	},
	-- FORMATTER
	{
		"stevearc/conform.nvim",
		event = { "BufEnter", "BufNewFile", "BufWritePost" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
	},
	-- LINTER
	{
		"mfussenegger/nvim-lint",
		event = { "BufEnter", "BufNewFile", "BufWritePost" },
	},

	-- AUTO HIGHLIGHT
	{
		"RRethy/vim-illuminate",
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
	},
	-- FILE FINDER
	{
		"nvim-telescope/telescope.nvim",
		--tag = '0.1.4'   , or
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- PROJECT MANAGER
	{
		"ahmedkhalf/project.nvim",
	},
	-- BUFFFERLINE
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},
	-- TERMINAL INTEGRATION
	{
		{ "akinsho/toggleterm.nvim", version = "*", config = true },
	},
	-- AUTO PAIR
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
	},
	-- GIT INTERGRATION
	{
		"lewis6991/gitsigns.nvim",
	},
	-- INDENTATION
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
	},
	-- COMMMENTS
	{
		"numToStr/Comment.nvim",
		lazy = false,
	},
	-- SCREEN STARTUP
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	-- TELESCOPE BROWSER
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
})
