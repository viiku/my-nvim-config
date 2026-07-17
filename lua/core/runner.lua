-- Run the current file in a terminal split, based on filetype.
-- Wired up in init.lua via `require("core.runner")`.

local utils = require("core.utils")

-- Command template per filetype. %s is replaced with the shell-escaped
-- absolute path of the current buffer's file.
local commands = {
	python = "python3 %s",
	javascript = "node %s",
	typescript = "npx ts-node %s",
	lua = "lua %s",
	sh = "bash %s",
	go = "go run %s",
	rust = "cargo run",
}

local function run_current_file()
	local ft = vim.bo.filetype
	local cmd_template = commands[ft]

	if not cmd_template then
		vim.notify("core.runner: no run command configured for filetype '" .. ft .. "'", vim.log.levels.WARN)
		return
	end

	local file = vim.fn.expand("%:p")
	if file == "" then
		vim.notify("core.runner: current buffer has no file to run", vim.log.levels.WARN)
		return
	end

	local cmd = string.format(cmd_template, vim.fn.shellescape(file))
	utils.open_term(utils.term_dir(), cmd)
end

vim.keymap.set("n", "<leader>rr", run_current_file, { desc = "Run current file" })
