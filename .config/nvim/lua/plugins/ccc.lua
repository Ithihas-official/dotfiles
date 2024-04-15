local M = {
	"uga-rosa/ccc.nvim",
}

M.config = function()
	local ccc = require("ccc")
	local mapping = ccc.mapping

	ccc.setup({
		highlighter = {
			auto_enable = true,
			lsp = true,
		},
	})
end

return M
