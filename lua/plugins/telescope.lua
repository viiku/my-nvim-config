-- Fuzzy finder and search interface

return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					layout_strategy = "flex",
					layout_config = {
						width = 0.95,
						height = 0.95,
						preview_cutoff = 100,
					},
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_to_qflist,
						},
					},
				},
			})
		end,
		desc = "Fuzzy finder with powerful capabilities",
	},
}
