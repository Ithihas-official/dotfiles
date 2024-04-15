local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-emoji",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-buffer",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-path",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-cmdline",
			event = "InsertEnter",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			event = "InsertEnter",
		},
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
		{
			"hrsh7th/cmp-nvim-lua",
		},
		{
			"roobert/tailwindcss-colorizer-cmp.nvim",
		},
	},
}

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	require("luasnip.loaders.from_vscode").lazy_load()
	-- require("luasnip").filetype_extend("javascript", { "javascriptreact" })
	-- require("luasnip").filetype_extend("javascript", { "html" })

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	--   פּ ﯟ   some other good icons
	local kind_icons = {
		Text = " ",
		Method = "󰆧  ",
		Function = "󰊕",
		Variable = "󰂡",
		Class = "󰠱 ",
		Interface = "  ",
		Module = "  ",
		Unit = " ",
		Value = "󰎠 ",
		Enum = " ",
		Keyword = "󰌋 ",
		Color = "󰏘 ",
		File = "󰈙 ",
		Reference = " ",
		Folder = "󰉋 ",
		EnumMember = " ",
		Constant = "󰏿",
		Struct = "  ",
		Event = " ",
		Operator = "󰆕 ",
		TypeParameter = "󰅲",
		Constructor = "",
		Field = "",
		Property = "",
		Snippet = "",
	}

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = cmp.config.sources({
			{ name = "path" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "tags" },
			{ name = "luasnip" }, -- For luasnip users.
			{ name = "treesitter" },
			{ name = "markdown" },
			--{ name = 'vsnip' }, -- For vsnip users.
			-- { name = "ultisnips" }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
			providers = {
				markdown = {
					name = "RenderMarkdown",
					module = "render-markdown.integ.blink",
					fallbacks = { "lsp" },
				},
			},
		}),

		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				local highlights_info = require("colorful-menu").cmp_highlights(entry)
				if highlights_info ~= nil then
					vim_item.abbr_hl_group = highlights_info.highlights
					vim_item.abbr = highlights_info.text
				end
				-- Kind icons
				-- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					luasnip = "[Snippet]",
					buffer = "[Buffer]",
					path = "[Path]",
				})[entry.source.name]
				return vim_item
			end,
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = cmp.config.window.bordered({
				winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
			}),
			documentation = cmp.config.window.bordered({
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
			}),
		},

		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		mapping = {
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		},
	})
end
return M
