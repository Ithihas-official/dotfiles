require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"eslint",
		"prosemd_lsp",
		"jdtls",
		"lua_ls",
		"unocss",
		"emmet_ls",
		"marksman",
		"pyright",
		"tailwindcss",
		"yamlls",
		"cssls",
		"cssmodules_ls",
		"rust_analyzer",
		"clangd",
		"tsserver",
	},
})

-- install prettier and prettierd for formating
-- install black and flake8 for python formatting and diagnostics
-- for lsp servers : https://github.com/williamboman/mason-lspconfig.nvim
