local o, opt = vim.o, vim.opt


vim.g.mapleader      = " "
vim.g.localmapleader = ","
vim.g.codium_disable_bindings = true

opt.spell     = true
opt.spelllang = 'en_us'
opt.spelloptions:append('camel')
opt.spellcapcheck = ""

opt.nu             = true
opt.relativenumber = true


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

opt.tabstop                 = 4
opt.ignorecase              = true
opt.softtabstop             = 4
opt.shiftwidth              = 4
opt.expandtab               = true
opt.termguicolors           = true
vim.g.loaded_matchit            = 1
opt.paste                   = false
opt.ai                      = true

opt.splitbelow              = true
opt.splitright              = true

opt.smartindent             = true

opt.swapfile                = false
opt.backup                  = false
opt.undodir                 = vim.fn.expand("$HOME/.vim/undodir")
opt.undofile                = true

opt.incsearch               = true

opt.scrolloff               = 7
opt.sidescrolloff           = 5
opt.showmode                = false
opt.cursorline              = true

-- opt.formatoptions = opt.formatoptions - 'o' + 'r' - '2' - 'j'
opt.formatoptions = {
    ["1"] = true,
    ["2"] = true, -- Use indent from 2nd line of a paragraph
    q = true, -- continue comments with gq"
    c = true, -- Auto-wrap comments using textwidth
    r = true, -- Continue comments when pressing Enter
    n = true, -- Recognize numbered lists
    t = false, -- autowrap lines using text width value
    j = true, -- remove a comment leader when joining lines.
    -- Only break if the line was not longer than 'textwidth' when the insert
    -- started and only at a white character that has been entered during the
    -- current insert command.
    l = true,
    o = false,
    v = true,
}

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"


-- Folding options
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldenable = true

opt.laststatus = 3
opt.splitkeep = 'screen'

opt.shortmess = {
    t = true, -- truncate file messages at start
    A = true, -- ignore annoying swap file messages
    o = true, -- file-read message overwrites previous
    O = true, -- file-read message overwrites previous
    T = true, -- truncate non-file messages in middle
    -- F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
    s = true,
    c = true,
    W = true, -- Don't show [w] or written when writing
}

o.switchbuf = "useopen,uselast"
opt.fillchars = {
    eob = " ",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "",
}

opt.diffopt = opt.diffopt
+ {
    "vertical",
    "iwhite",
    "hiddenoff",
    "foldcolumn:0",
    "context:4",
    "algorithm:histogram",
    "indent-heuristic",
    "linematch:60",
}

o.linebreak = true
o.confirm = true
o.pumheight = 15

opt.guicursor = {
    "n-v-c-sm:block-Cursor",
    "i-ci-ve:ver25-iCursor",
    "r-cr-o:hor20-Cursor",
    "a:blinkon0",
}
opt.cursorlineopt = { "both" }
