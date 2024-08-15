vim.api.nvim_buf_set_option(0, "wrap", true)
vim.api.nvim_buf_set_option(0, "linebreak", true)
vim.api.nvim_buf_set_option(0, "smartindent", true)
vim.api.nvim_buf_set_option(0, "autoindent", true)
vim.api.nvim_buf_set_option(0, "breakindentopt", "list:-1")
vim.api.nvim_buf_set_option(0, "formatlistpat", [[^\s*[-\*\~]\+[\.\)]*\s\+]])

vim.api.nvim_buf_set_option(0, "textwidth", 180)
vim.api.nvim_buf_set_option(0, "colorcolumn", "180")

-- TODO: Make this fail gracefully
-- Also is it possible to have this in a way that it keeps the nice looking folds?
require('ufo').detach()
