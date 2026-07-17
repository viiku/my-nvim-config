-- Git integration plugins

return {
	{
		"gitsigns.nvim",
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>hd", gs.diffthis, { desc = "Diff this file" })
				end,
			})
		end,
		desc = "Git diff signs in line numbers",
	},

	{
		"neogit",
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
		},
		config = function()
			require("neogit").setup()
		end,
		desc = "Git client (like Magit in Emacs)",
	},

	{
		"diffview.nvim",
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
		config = function()
			require("diffview").setup()
		end,
		desc = "Unified diff view",
	},
}
