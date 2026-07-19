local map = vim.keymap.set

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- FILE & BUFFER OPERATIONS
-- ============================================================================

map("n", "<leader>w", "<cmd>w<cr>",   { desc = "Save file" }) 
map("n", "<leader>W", "<cmd>wa<cr>",  { desc = "Save all files" }) 
map("n", "<leader>q", "<cmd>q<cr>",   { desc = "Quit" }) 
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

-- Buffer navigation
map("n", "<S-l>", "<cmd>bnext<cr>",         { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>",     { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>",  { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>%bdelete<cr>", { desc = "Delete all buffers" })
map("n", "<leader>bn", "<cmd>enew<cr>",     { desc = "New buffer" })

-- ============================================================================
-- WINDOW NAVIGATION & MANAGEMENT
-- ============================================================================

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" }) 
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" }) 
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" }) 
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })

-- Resize windows with arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>",             { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>",           { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>",  { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Split Management
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>",  { desc = "Split horizontal" })
map("n", "<leader>sc", "<cmd>close<cr>",  { desc = "Close current split" })
map("n", "<leader>so", "<cmd>only<cr>",   { desc = "Close other splits" })
map("n", "<leader>s=", "<C-w>=",          { desc = "Equalize split sizes" })
map("n", "<leader>sx", "<C-w>x",          { desc = "Swap with next split" })

-- ============================================================================
-- TAB MANAGEMENT
-- ============================================================================

map("n", "<leader>tn", "<cmd>tabnew<cr>",      { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>",    { desc = "Close tab" })
map("n", "<leader>t>", "<cmd>tabnext<cr>",     { desc = "Next tab" })
map("n", "<leader>t<", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<leader>tmp", "<cmd>tabmove +1<cr>", { desc = "Move tab forward" })
map("n", "<leader>tmn", "<cmd>tabmove -1<cr>", { desc = "Move tab backward" })

-- ============================================================================
-- TERMINAL
-- ============================================================================

-- Terminal mode: exit insert + jump to split in one key
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: jump to left split" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: jump to lower split" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: jump to upper split" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: jump to right split" })
map("t", "<Esc><Esc>", "<C-\\><C-n>",  { desc = "Terminal: exit insert mode" })

-- Auto-insert mode when entering terminal
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("TermAutoInsert", { clear = true }),
	callback = function()
		if vim.bo.buftype == "terminal" and not vim.b.nvim_runner then
			vim.cmd("startinsert")
		end
	end,
})

-- Terminal helpers (shared with core.runner)
local utils = require("core.utils")

map("n", "<leader>st", function() utils.open_term(utils.term_dir()) end, { desc = "Terminal in file dir" })
map("n", "<leader>sT", function() utils.open_term(vim.fn.getcwd()) end,  { desc = "Terminal in cwd" })

-- ============================================================================
-- SEARCH & NAVIGATION
-- ============================================================================

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })

-- Keep cursor centered when scrolling/searching
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Previous search centered" })

-- ============================================================================
-- EDITING
-- ============================================================================

-- Move lines up/down (normal mode)
map("n", "<A-j>", "<cmd>move .+1<cr>", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>move .-2<cr>", { desc = "Move line up" })

-- Move lines up/down (visual mode)
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Don't lose selection when indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Yank to end of line (consistent with D, C)
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Paste without overwriting register
map("x", "<leader>p", '"_dP', { desc = "Paste without yank" })

-- Better undo/redo
map("n", "<leader>u", "<cmd>undo<cr>", { desc = "Undo" })
map("n", "<leader>U", "<cmd>redo<cr>", { desc = "Redo" })

-- Increment/Decrement
map("n", "<C-a>", "<C-a>", { desc = "Increment number" })
map("n", "<C-x>", "<C-x>", { desc = "Decrement number" })

-- ============================================================================
-- FORMATTING
-- ============================================================================

-- Format entire file
map("n", "<leader>fm", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format file" })

map("v", "<leader>fm", function()
	vim.lsp.buf.format()
end, { desc = "Format selection" })

-- ============================================================================
-- FINDER & FILE TREE (Telescope)
-- ============================================================================

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",   { desc = "Find in files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",     { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",   { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",    { desc = "Recent files" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>",    { desc = "Commands" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Grep word" })

-- ============================================================================
-- GIT KEYMAPS (Neogit / Diffview)
-- ============================================================================

map("n", "<leader>gg", "<cmd>Neogit<cr>",                { desc = "Git status (Neogit)" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>",          { desc = "Diff view" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
map("n", "<leader>gc", "<cmd>DiffviewClose<cr>",         { desc = "Close diff view" })

-- ============================================================================
-- MISCELLANEOUS
-- ============================================================================

-- Toggle line wrapping
map("n", "<leader>zw", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })

-- Toggle relative line numbers
map("n", "<leader>zn", "<cmd>set rnu!<cr>", { desc = "Toggle relative numbers" })

-- Toggle spell check
map("n", "<leader>zs", "<cmd>set spell!<cr>", { desc = "Toggle spell check" })

-- Go to start/end of line
map("n", "H", "^", { desc = "Go to line start" })
map("n", "L", "$", { desc = "Go to line end" })
map("v", "H", "^", { desc = "Go to line start" })
map("v", "L", "$", { desc = "Go to line end" })

-- Show keymaps
map("n", "<leader>?", "<cmd>Telescope keymaps<cr>", { desc = "Show keymaps" })

-- Browser toggle
map("n", "<leader>e", "<cmd>Explore<cr>", { desc = "Open file explorer (netrw)" })
map("n", "<C-^>", "<C-^>", { desc = "Toggle previous buffer" })


