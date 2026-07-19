-- Plugin manager entrypoint
-- Plugin specs are split by category under lua/pugins/*.lua
require("lazy").setup({
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.lsp" },
    { import = "plugins.completion" },
    { import = "plugins.git" },
}, {
    ui = { border = "rounded" },
    checker = { enabled = false },
    change_detection = { enabled = false },
    git = { timeout = 10 },
})
