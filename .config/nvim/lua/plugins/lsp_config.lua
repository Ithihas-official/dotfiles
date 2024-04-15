local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"SmiteshP/nvim-navic",
			"SmiteshP/nvim-navbuddy",
		},
	},
}

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "<CR>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.keymap.set("n", "K", function()
		local winid = require("ufo").peekFoldedLinesUnderCursor()
		if not winid then
			vim.lsp.buf.hover()
		end
	end)

	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<space>DF", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end
M.on_attach = function(client, bufnr)
	local navbuddy = require("nvim-navbuddy")
	lsp_keymaps(bufnr)
	if client.server_capabilities["documentSymbolProvider"] then
		require("nvim-navic").attach(client, bufnr)
	end
	if client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true)
	end

	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Document Highlight",
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Clear All the References",
		})
	end

	navbuddy.attach(client, bufnr)
end

M.toggle_inlay_hints = function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end

function M.common_capabilities()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then
		return cmp_nvim_lsp.default_capabilities()
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	return capabilities
end

function M.config()
	vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
	local lspconfig = require("lspconfig")
	local icons = require("user.icons")

	local c_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	c_capabilities.offsetEncoding = { "utf-16" }

	local servers = {

		"cssls",
		"ts_ls",
		"clangd",
		"cssls",
		"cssmodules_ls",
		"lua_ls",
		"unocss",
		"eslint",
		"emmet_ls",
		"rust_analyzer",
		"marksman",
		"pyright",
		"tailwindcss",
		"jsonls",
		"tailwindcss",
		"yamlls",
		"jdtls",
		"html",
		"quick_lint_js",
	}

	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
				[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
				[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
				[vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
			},
		},
		virtual_text = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			header = "",
			prefix = "",
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	require("lspconfig.ui.windows").default_options.border = "rounded"

	for _, server in pairs(servers) do
		local opts = {
			on_attach = M.on_attach,
			capabilities = M.common_capabilities(),
		}

		local require_ok, settings = pcall(require, "plugins.lspsettings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end

		lspconfig[server].setup(opts)

		if server == "nginx-language-server" then
			require("lspconfig").nginx_language_server.setup(opts)
		end
	end

	lspconfig.rust_analyzer.setup({
		-- on_attach = on_attach,
		-- capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				command = "clippy",
			},
		},
	})

	lspconfig.jdtls.setup({
		-- on_attach = on_attach,
		-- capabilities = capabilities,
		cmd = { "jdtls" },
		filetypes = { "java" },
	})
end

return M
