local map = vim.keymap.set

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Faster save/quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" }) 
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" }) 
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })

-- Better window highlight
map("n", "<C-h>", "C-w>h", { desc = "Move to left split" }) 
map("n", "<C-l>", "C-w>l", { desc = "Move to right split" }) 
map("n", "<C-j>", "C-w>j", { desc = "Move to lower split" }) 
map("n", "<C-k>", "C-w>k", { desc = "Move to upper split" })

-- Terminal mode: exit insert + jump to split in one key
-- (without these you'd need Ctrl+\ Ctrl+n first, then <C-w>h> etc.)
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: jump to left split" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: jump to lower split" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: jump to upper split" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: jump to right split" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal: exit insert mode" })

-- When you focus an interactive terminal window, drop straight into terminal
-- (insert) mode so the shell takes your keystrokes immediately - <Up>/<C-r>
-- recall shell history, etc. Without this you land in termianl-normal mode where
-- those keys move the Vim cursor instead. Runner terminals are skipped (they use
-- `q` in normal mode to close). To scroll a terminal, press <Esc><Esc>.
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("TermAutoInsert", { clear = true }),
	callback = function()
		if vim.bo.buftype == "terminal" and not vim.b.nvim_runner then
			vim.cmd("startinsert")
		end
	end,
})

-- Resize windows
map("n", "<C-Up>",    "<cmd>resize +2<cr>")
map("n", "<C-Down>",  "<cmd>resize -2<cr>")
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- Split Management
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>",  { desc = "Split horizontal" })
map("n", "<leader>sc", "<cmd>close<cr>",  { desc = "Close current split" })
map("n", "<leader>so", "<cmd>only<cr>",   { desc = "Close other splits" })
map("n", "<leader>s=", "<C-w>=",          { desc = "Equalize split sizes" })
map("n", "<leader>sx", "<C-w>x",          { desc = "Swap with next split" })

-- Terminal in a split, opened in the current file's directory (st) or at the
-- git/project root (sT). Unlike bare :term (which uses Neovim's global cwd),
-- these cd into the right place first, The split stays in the CURRENT window's
-- column (belowright) instead of spanning the full width across both columns.
local function term_dir()
	local function dir_of(buf)
		if vim.bo[buf].buftype ~= "" then return nil end           -- skip terminals/trees/etc.
		local name = vim.api.nvim_buf_get_name(buf)
		if name == "" then return nil end
		local d = vim.fn.fnamemodify(name, ":h")
		return (vim.fn.isdirectory(d) == 1) and d or nil
	end
	-- the file in the current window, else any file window in this tab, else cwd
	local d = dir_of(vim.api.nvim_tabpage_list_wins(0)) do
	if d then return d end
	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		d = dir_of(vim.api.nvim_win_get_buf(w))
		if d then return d end
	end
	return vim.fn.getcwd()
end
local function open_term(dir)
	vim.cmd("belowright 15new")    -- split the current window only (stays in its column)
	vim.cmd("lcd " .. vim.fn.fnameescape(dir))
	vim.cmd("terminal")
	vim.cmd("startinsert")
end







-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>",        { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>",      { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabnext<cr>",       { desc = "Next tab" })
map("n", "<leader>tn", "<cmd>tabprevious<cr>",   { desc = "Previous tab" })

-- Buffer navigation
map("n", "<S-l>", "<cmd>bnext<cr>",                { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>",            { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>",         { desc = "Delete buffer" })

-- Move lines up/down (visual mode)
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move seletion down" })
map("v", "K", ":m '>-2<cr>gv=gv", { desc = "Move seletion up" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Don't lose selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Yank to end of line (consistent with D, C)
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Paste without overwriting register
map("x", "<leader>p", '"_dP', { desc = "Paste without yank" })

-- Telescopes
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- File tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
map("n", "<leader>E", "<cmd>NvimTreeFocus<cr>",  { desc = "Focus file tree" })

-- Git (Neogit / Diffview)
-- Status & UI
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Git status (Neogit)" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff view (staged vs working)" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff view (staged vs working)" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff view (staged vs working)" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff view (staged vs working)" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff view (staged vs working)" })

