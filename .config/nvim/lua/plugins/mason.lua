local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-lua/plenary.nvim",
	},
}

M.execs = {
	"quick_lint_js",
	"eslint",
	"prosemd_lsp",
	"jdtls",
	"lua_ls",
	"unocss",
	"html",
	"emmet_ls",
	"marksman",
	"pyright",
	"tailwindcss",
	"yamlls",
	"cssls",
	"cssmodules_ls",
	"rust_analyzer",
	"clangd",
	"ts_ls",
	-- "codespell",
	-- "markdownlint",
	-- "prettierd",
	-- "prettier",
	-- "clang-format",
	-- "black",
	-- "jq",
	-- "stylua",
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})
	require("mason-lspconfig").setup({
		ensure_installed = M.execs,
	})
end

return M
