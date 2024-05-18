vim.bo.wrap = true
vim.bo.linebreak = true
vim.bo.smartindent = true
vim.bo.autoindent = true
vim.bo.breakindentopt = "list:-1"
vim.bo.formatlistpat = [[^\s*[-\*\~]\+[\.\)]*\s\+]]

vim.bo.colorcolumn = "180"
vim.bo.textwidth = 180

-- TODO: Make this fail gracefully
-- Also is it possible to have this in a way that it keeps the nice looking folds?
require('ufo').detach()
