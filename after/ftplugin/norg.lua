vim.o.wrap = true
vim.o.linebreak = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.breakindentopt = "list:-1"
vim.o.formatlistpat = [[^\s*[-\*\~]\+[\.\)]*\s\+]]

vim.o.colorcolumn = "180"
vim.bo.textwidth = 180

-- TODO: Make this fail gracefully
-- Also is it possible to have this in a way that it keeps the nice looking folds?
require('ufo').detach()
