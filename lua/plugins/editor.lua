-- Core editor enhancements and text manipulation plugins

return {
	{
		"vim-repeat",
		"tpope/vim-repeat",
		keys = { "." },
		desc = "Enable repeat (.) for plugin maps",
	},

	{
		"vim-surround",
		"tpope/vim-surround",
		event = "BufReadPost",
		desc = "Quoting/parenthesizing made simple (cs, ds, ys)",
	},

	{
		"comment.nvim",
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		config = function()
			require("Comment").setup()
		end,
		desc = "Smart and powerful comment plugin (gc, gb)",
	},

	{
		"nvim-autopairs",
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
		desc = "Autopair brackets, quotes, etc.",
	},

	{
		"indent-blankline.nvim",
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { enabled = true },
			})
		end,
		desc = "Add indentation guides",
	},

	{
		"todo-comments.nvim",
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
		desc = "Highlight and search TODO comments",
	},
}
