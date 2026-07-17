-- LSP configuration and package managers

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-cmp" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Common servers (install with :Mason)
			local servers = { "lua_ls", "gopls", "jdtls", "pyright", "yamlls" }

			for _, server in ipairs(servers) do
				lspconfig[server].setup({ capabilities = capabilities })
			end

			-- Global LSP keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
				callback = function(event)
					local map = vim.keymap.set
					local opts = { buffer = event.buf }

					map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
					map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
					map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
					map("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
					map("n", "<leader>rn", vim.lsp.buf.rename, opts)
					map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					map("n", "K", vim.lsp.buf.hover, opts)
					map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				end,
			})
		end,
		desc = "Language Server Protocol client",
	},

	{
		"williamboman/mason.nvim",
		name = "mason.nvim",
		build = ":MasonUpdate",
		cmd = "Mason",
		config = function()
			require("mason").setup()
		end,
		desc = "Package manager for LSP servers, DAP, etc.",
	},

	{
		"williamboman/mason-lspconfig.nvim",
		name = "mason-lspconfig.nvim",
		dependencies = { "mason.nvim", "nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({ automatic_installation = true })
		end,
		desc = "Bridge between Mason and LSPConfig",
	},
}
