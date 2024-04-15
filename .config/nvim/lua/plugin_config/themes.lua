-- TOKYONIGHT CONFIGURATION
require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	light_style = "day", -- The theme is used when the background is set to light
	transparent = true, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = { bold = true },
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	--- @param colors ColorScheme
	on_colors = function(colors) end,

	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	--- @param highlights Highlights
	--- @param colors ColorScheme
	on_highlights = function(highlights, colors) end,
})

-- NORDIC CONFIGURATION

require("nordic").setup({
	-- This callback can be used to override the colors used in the palette.
	on_palette = function(palette)
		return palette
	end,
	-- Enable bold keywords.
	bold_keywords = true,
	-- Enable italic comments.
	italic_comments = true,
	-- Enable general editor background transparency.
	transparent_bg = true,
	-- Enable brighter float border.
	bright_border = true,
	-- Reduce the overall amount of blue in the theme (diverges from base Nord).
	reduced_blue = true,
	-- Swap the dark background with the normal one.
	swap_backgrounds = false,
	-- Override the styling of any highlight group.
	override = {},
	-- Cursorline options.  Also includes visual/selection.
	cursorline = {
		-- Bold font in cursorline.
		bold = true,
		-- Bold cursorline number.
		bold_number = true,
		-- Avialable styles: 'dark', 'light'.
		theme = "dark",
		-- Blending the cursorline bg with the buffer bg.
		blend = 0.7,
	},
	noice = {
		-- Available styles: `classic`, `flat`.
		style = "flat",
	},
	telescope = {
		-- Available styles: `classic`, `flat`.
		style = "flat",
	},
	leap = {
		-- Dims the backdrop when using leap.
		dim_backdrop = false,
	},
	ts_context = {
		-- Enables dark background for treesitter-context window
		dark_background = true,
	},
})

-- CATPPUCCIN

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = true, -- disables setting the background color.
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = { "bold" },
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = { "bold" },
		properties = { "italic" },
		types = {},
		operators = {},
	},
	color_overrides = {},
	custom_highlights = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})
