-- Lazy.nvim Plugin Specifications
-- This file contains all plugin configurations for Neovim

local plugins = {
	-- ============================================================================
	-- CORE EDITOR ENHANCEMENTS
	-- ============================================================================

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

	-- ============================================================================
	-- UI/UX IMPROVEMENTS
	-- ============================================================================

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

	-- ============================================================================
	-- COMPLETION & SNIPPETS
	-- ============================================================================

	{
		"nvim-cmp",
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
				}),
			})

			-- Command mode completion
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
		desc = "Completion engine",
	},

	{
		"LuaSnip",
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		desc = "Snippet engine",
	},

	-- ============================================================================
	-- LSP & DIAGNOSTICS
	-- ============================================================================

	{
		"nvim-lspconfig",
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-cmp" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Common servers (install with :Mason)
			local servers = { "lua_ls", "pyright", "ts_ls", "gopls", "rust_analyzer" }

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
		"mason.nvim",
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = "Mason",
		config = function()
			require("mason").setup()
		end,
		desc = "Package manager for LSP servers, DAP, etc.",
	},

	{
		"mason-lspconfig.nvim",
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim", "nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({ automatic_installation = true })
		end,
		desc = "Bridge between Mason and LSPConfig",
	},

	-- ============================================================================
	-- TELESCOPE (FUZZY FINDER)
	-- ============================================================================

	{
		"telescope.nvim",
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
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
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			telescope.load_extension("fzf")
		end,
		desc = "Fuzzy finder with powerful capabilities",
	},

	-- ============================================================================
	-- FILE EXPLORER
	-- ============================================================================

	{
		"nvim-tree.lua",
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
		keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>" } },
		config = function()
			require("nvim-tree").setup({
				view = { width = 30 },
				renderer = {
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
						},
					},
				},
				filters = {
					dotfiles = false,
					git_ignored = false,
				},
			})
		end,
		desc = "File explorer tree",
	},

	-- ============================================================================
	-- GIT INTEGRATION
	-- ============================================================================

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

	-- ============================================================================
	-- COLORSCHEMES
	-- ============================================================================

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

	-- ============================================================================
	-- TREESITTER (SYNTAX HIGHLIGHTING & PARSING)
	-- ============================================================================

	{
		"nvim-treesitter",
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua", "python", "javascript", "typescript", "rust", "go",
					"json", "yaml", "toml", "markdown", "bash", "html", "css",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<C-s>",
						node_decremental = "<M-space>",
					},
				},
			})
		end,
		desc = "Better syntax highlighting & parsing",
	},

	{
		"nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufReadPost",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
					},
				},
			})
		end,
		desc = "Treesitter-based text objects",
	},

	-- ============================================================================
	-- FORMATTING & LINTING
	-- ============================================================================

	{
		"conform.nvim",
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black", "isort" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
					markdown = { "prettier" },
					yaml = { "prettier" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
		desc = "Formatter plugin",
	},

	-- ============================================================================
	-- TESTING
	-- ============================================================================

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

	-- ============================================================================
	-- DEBUGGING (DAP)
	-- ============================================================================

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

	-- ============================================================================
	-- THEME/APPEARANCE
	-- ============================================================================

	{
		"nvim-scrollbar",
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup()
		end,
		desc = "Scrollbar",
	},

	-- ============================================================================
	-- UTILITIES
	-- ============================================================================

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

return plugins
