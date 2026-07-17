-- UI/UX improvements, themes, and visual enhancements

return {
	{
		"nvim-web-devicons",
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		desc = "File icons for various plugins",
	},

	{
		"nvim-navic",
		"SmiteshP/nvim-navic",
		lazy = true,
		config = function()
			require("nvim-navic").setup({ icons = require("nvim-web-devicons").get_icons() })
		end,
		desc = "Show breadcrumb navigation bar",
	},

	{
		"lualine.nvim",
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-web-devicons", "nvim-navic" },
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
					lualine_c = { "filename", { "navic", draw_empty = false } },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
		desc = "Statusline",
	},

	{
		"dressing.nvim",
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
		desc = "Improved input/select UI",
	},

	{
		"which-key.nvim",
		"folke/which-key.nvim",
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
		"bufferline.nvim",
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					mode = "tabs",
					themable = true,
					color_icons = true,
				},
			})
		end,
		desc = "Tabline with buffers",
	},

	{
		"nvim-scrollbar",
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup()
		end,
		desc = "Scrollbar",
	},

	{
		"catppuccin",
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
		desc = "Catppuccin color scheme",
	},
}
