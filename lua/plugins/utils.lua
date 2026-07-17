-- Utility plugins

return {
	{
		"nvim-lua/plenary.nvim",
		name = "plenary.nvim",
		lazy = true,
		desc = "Lua utility library",
	},

	{
		"mbbill/undotree",
		name = "undotree",
		cmd = "UndotreeToggle",
		keys = { { "<leader>ut", "<cmd>UndotreeToggle<cr>" } },
		desc = "Undo tree visualizer",
	},

	{
		"stevearc/oil.nvim",
		name = "oil.nvim",
		cmd = "Oil",
		keys = { { "-", "<cmd>Oil<cr>" } },
		config = function()
			require("oil").setup()
		end,
		desc = "File browser as a buffer",
	},
}
