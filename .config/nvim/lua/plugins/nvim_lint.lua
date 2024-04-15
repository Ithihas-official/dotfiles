local M = {
	"mfussenegger/nvim-lint",
	event = { "BufEnter", "BufNewFile", "BufWritePost" },
}

function M.config()
	local lint = require("lint")

	lint.linters_by_ft = {
		markdown = { "markdownlint" },
		javascript = { "quick-lint-js" },
		javascriptreact = { "quick-lint-js" },
		typescipt = { "quick-lint-js" },
		typescriptreact = { "quick-lint-js" },
		lua = { "selene" },
		c = { "cpplint" },
		cpp = { "cpplint" },
		python = { "flake8" },
		yaml = { "yamllint" },
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
		group = lint_augroup,
		callback = function()
			require("lint").try_lint()
		end,
	})

	vim.keymap.set("n", "<leader>l", function()
		lint.try_lint()
	end, { desc = "Trigger linting for current file" })
end

return M
