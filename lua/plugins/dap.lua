-- Debugging and testing plugins

return {
	{
		"nvim-dap",
		"mfussenegger/nvim-dap",
		cmd = "DapToggleBreakpoint",
		config = function()
			local dap = require("dap")

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
		end,
		desc = "Debug Adapter Protocol client",
	},

	{
		"nvim-dap-ui",
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-dap" },
		config = function()
			require("dapui").setup()
		end,
		desc = "DAP UI",
	},

	{
		"neotest",
		"nvim-neotest/neotest",
		cmd = "Neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({ dap = { justMyCode = true } }),
					require("neotest-go"),
				},
			})
		end,
		desc = "Testing framework integration",
	},
}
