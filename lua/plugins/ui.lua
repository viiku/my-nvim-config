-- UI/UX improvements, themes, and visual enhancements

return {
	{
		"nvim-tree/nvim-web-devicons",
		name = "nvim-web-devicons",
		lazy = true,
		desc = "File icons for various plugins",
	},

	{
		"nvim-lualine/lualine.nvim",
		name = "lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = { left = "│", right = "│" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
		desc = "Statusline",
	},

	{
		"folke/which-key.nvim",
		name = "which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				window = { padding = { 2, 2 } },
				layout = { align = "center" },
			})
		end,
		desc = "Show keybindings popup",
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = false,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
		desc = "Catppuccin color scheme",
	},
}
