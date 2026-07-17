-- Code formatting and linting

return {
	{
		"stevearc/conform.nvim",
		name = "conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black", "isort" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
					markdown = { "prettier" },
					yaml = { "prettier" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
		desc = "Formatter plugin",
	},
}
