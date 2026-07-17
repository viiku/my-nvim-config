-- Core editor enhancements and text manipulation plugins

return {
	{
		"tpope/vim-repeat",
		name = "vim-repeat",
		keys = { "." },
		desc = "Enable repeat (.) for plugin maps",
	},

	{
		"tpope/vim-surround",
		name = "vim-surround",
		event = "BufReadPost",
		desc = "Quoting/parenthesizing made simple (cs, ds, ys)",
	},

	{
		"numToStr/Comment.nvim",
		name = "comment.nvim",
		event = "BufReadPost",
		config = function()
			require("Comment").setup()
		end,
		desc = "Smart and powerful comment plugin (gc, gb)",
	},

	{
		"windwp/nvim-autopairs",
		name = "nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
		desc = "Autopair brackets, quotes, etc.",
	},
}
