local M = {
	"mfussenegger/nvim-lint",
	event = { "BufEnter", "BufNewFile", "BufWritePost" },
}

function M.config()
	local lint = require("lint")

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	lint.linters_by_ft = {
		markdown = { "markdownlint" },
		javascript = { "quick-lint-js", "eslint", "eslint_d" },
		javascriptreact = { "quick-lint-js", "eslint", "eslint_d" },
		typescipt = { "quick-lint-js", "eslint", "eslint_d" },
		typescriptreact = { "quick-lint-js", "eslint", "eslint_d" },
		lua = { "selene" },
		c = { "cpplint" },
		cpp = { "cpplint" },
		python = { "flake8" },
		yaml = { "yamllint" },
	}

	local function find_nearest_node_modules_dir()
		-- current buffer dir
		local current_dir = vim.fn.expand("%:p:h")
		while current_dir ~= "/" do
			if vim.fn.isdirectory(current_dir .. "/node_modules") == 1 then
				return current_dir
			end
			current_dir = vim.fn.fnamemodify(current_dir, ":h")
		end
		return nil
	end

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
		group = lint_augroup,
		callback = function()
			local ft = vim.bo.filetype
			local js_types = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
			if not vim.tbl_contains(js_types, ft) then
				lint.try_lint()
				return
			end
			local original_cwd = vim.fn.getcwd()
			local node_modules_dir = find_nearest_node_modules_dir()
			if node_modules_dir then
				vim.cmd("cd " .. node_modules_dir)
			end
			lint.try_lint()
			vim.cmd("cd " .. original_cwd)
		end,
	})

	-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
	-- 	group = lint_augroup,
	-- 	callback = function()
	-- 		require("lint").try_lint()
	-- 	end,
	--	})

	vim.keymap.set("n", "<leader>l", function()
		lint.try_lint()
	end, { desc = "Trigger linting for current file" })
end

return M
