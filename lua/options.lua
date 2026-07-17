local o = vim.opt

-- Line numbers
o.number = true
o.relativenumber = true

-- Indentation
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true 
o.autoindent = true

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

--  Appearance
--  Set background explicitly: auto-detection is disbaled via $NVIM_NOTTYFAST
--  (see README "E1568" node), so nvim can no longer probe the terminal for it.
o.background = "dark"
o.termguicolors = true
o.cursorline = true
o.signcolumn = "yes"
o.wrap = false
o.scrolloff = 8
o.sidescrolloff = 8
o.colorcolumn = "100"

-- Splits
o.splitright = true
o.splitbelow = true

-- Files
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undo"

-- Performance
o.updatetime = 250
o.timeoutlen = 300

-- Clipboard: sync with system clipboard
o.clipboard = "unnamedplus"

-- Mouse support
o.mouse = "a"

-- Show trailing whitespace and tabs
o.list = true
o.listchars = { tab = ">> ", trail = ".", nbsp = "." }

-- Keep buffers open in background
o.hidden = true
