vim.g.mapleader      = " "
vim.g.localmapleader = ","
vim.g.codium_disable_bindings = true

vim.opt.spell     = true
vim.opt.spelllang = 'en_us'
vim.opt.spelloptions:append('camel')

vim.opt.nu             = true
vim.opt.relativenumber = true

vim.cmd('set mouse=a')

vim.loader.enable()

vim.g.loaded_logiPat            = 1
vim.g.loaded_rrhelper           = 1
vim.g.loaded_tarPlugin          = 1
vim.g.loaded_gzip               = 1
vim.g.loaded_zipPlugin          = 1
vim.g.loaded_2html_plugin       = 1
vim.g.loaded_shada_plugin       = 1
vim.g.loaded_spellfile_plugin   = 1
vim.g.loaded_netrw              = 1
vim.g.loaded_netrwPlugin        = 1
vim.g.loaded_tutor_mode_plugin  = 1
vim.g.loaded_remote_plugins     = 1

vim.opt.tabstop                 = 4
vim.opt.ignorecase              = true
vim.opt.softtabstop             = 4
vim.opt.shiftwidth              = 4
vim.opt.expandtab               = true
vim.opt.termguicolors           = true
vim.g.loaded_matchit            = 1
vim.opt.paste                   = false
vim.opt.ai                      = true

vim.opt.splitbelow              = true
vim.opt.splitright              = true

vim.opt.smartindent             = true

vim.opt.swapfile                = false
vim.opt.backup                  = false
vim.opt.undodir                 = vim.fn.expand("$HOME/.vim/undodir")
vim.opt.undofile                = true

vim.opt.incsearch               = true

vim.opt.scrolloff               = 7
vim.opt.sidescrolloff           = 5
vim.opt.showmode                = false
vim.opt.cursorline              = true

vim.opt.formatoptions = vim.opt.formatoptions - 'o' + 'r' - '2' - 'j'

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

