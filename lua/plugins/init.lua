-- Main plugins module - combines all plugin categories

local plugins = {}

-- Load all plugin modules
local categories = {
	"editor",
	"ui",
	"completion",
	"lsp",
	"telescope",
	"treesitter",
	"formatting",
	"git",
	"utils",
}

for _, category in ipairs(categories) do
	local plugin_list = require("plugins." .. category)
	vim.list_extend(plugins, plugin_list)
end

return plugins
