local M = {

	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.api.nvim_set_keymap("n", "<Space>mp", ":MarkdownPreviewToggle<CR>", {})
	end,
	ft = { "markdown" },
}
return M
