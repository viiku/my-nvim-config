-- Shared helper functions used across the config

local M = {}

--- Find a sensible working directory for a new terminal/split:
--- the directory of the current buffer's file, falling back to
--- any other window in the tab, then to the current working dir.
function M.term_dir()
	local function dir_of(buf)
		if vim.bo[buf].buftype ~= "" then
			return nil
		end
		local name = vim.api.nvim_buf_get_name(buf)
		if name == "" then
			return nil
		end
		local d = vim.fn.fnamemodify(name, ":h")
		return (vim.fn.isdirectory(d) == 1) and d or nil
	end

	local d = dir_of(vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win()))
	if d then
		return d
	end

	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		d = dir_of(vim.api.nvim_win_get_buf(w))
		if d then
			return d
		end
	end

	return vim.fn.getcwd()
end

--- Open a terminal split in `dir`, optionally running `cmd`.
--- Sets vim.b.nvim_runner on the terminal buffer so the auto-insert
--- autocmd in keymaps.lua leaves insert-mode handling to the caller.
--- @param dir string directory to open the terminal in
--- @param cmd string|nil optional shell command to run immediately
function M.open_term(dir, cmd)
	vim.cmd("belowright 15new")
	vim.cmd("lcd " .. vim.fn.fnameescape(dir))
	vim.b.nvim_runner = true
	vim.cmd("terminal" .. (cmd and (" " .. cmd) or ""))
	vim.cmd("startinsert")
end

return M
