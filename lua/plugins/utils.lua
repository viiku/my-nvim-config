-- Utility plugins

return {
	{
		"plenary.nvim",
		"nvim-lua/plenary.nvim",
		lazy = true,
		desc = "Lua utility library",
	},

	{
		"undotree",
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = { { "<leader>ut", "<cmd>UndotreeToggle<cr>" } },
		desc = "Undo tree visualizer",
	},

	{
		"oil.nvim",
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = { { "-", "<cmd>Oil<cr>" } },
		config = function()
			require("oil").setup()
		end,
		desc = "File browser as a buffer",
	},

	{
		"nvim-lastplace",
		"ethanholz/nvim-lastplace",
		event = "BufReadPost",
		config = function()
			require("nvim-lastplace").setup()
		end,
		desc = "Return to last place in file",
	},

	{
		"vim-fugitive",
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		desc = "Git integration",
	},
}
