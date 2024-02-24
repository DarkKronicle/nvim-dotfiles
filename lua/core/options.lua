local o, opt, fn = vim.o, vim.opt, vim.fn

opt.nu = true

--------------------------------------------------------------------------------//
-- Tabs {{{1
--------------------------------------------------------------------------------//

opt.tabstop                 = 4
opt.softtabstop             = 4
opt.shiftwidth              = 4
opt.expandtab               = true
opt.smartindent             = true
opt.ai = true
opt.paste = false

--------------------------------------------------------------------------------//
-- Windows {{{1
--------------------------------------------------------------------------------//

opt.splitbelow              = true
opt.splitright              = true
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

--------------------------------------------------------------------------------//
-- UI {{{1
--------------------------------------------------------------------------------//

opt.scrolloff = 7
opt.sidescrolloff = 5
opt.cursorline = true
opt.relativenumber = true
opt.termguicolors = true
opt.mouse = 'a'
-- opt.showmode = false

-- Apparently allows blinking and other stuff
opt.guicursor = {
    "n-v-c-sm:block-Cursor",
    "i-ci-ve:ver25-iCursor",
    "r-cr-o:hor20-Cursor",
    "a:blinkon0",
}
opt.cursorlineopt = { "both" }



--------------------------------------------------------------------------------//
-- Diff {{{1
--------------------------------------------------------------------------------//

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

--------------------------------------------------------------------------------//
-- Format {{{1
--------------------------------------------------------------------------------//

opt.formatoptions = {
    ["1"] = true,
    ["2"] = true, -- Use indent from 2nd line of a paragraph
    q = true, -- continue comments with gq"
    c = true, -- Auto-wrap comments using textwidth
    r = true, -- Continue comments when pressing Enter
    n = true, -- Recognize numbered lists
    t = false, -- autowrap lines using text width value
    j = true, -- remove a comment leader when joining lines.
    o = false, -- Don't keep commenting if using o
    -- Only break if the line was not longer than 'textwidth' when the insert
    -- started and only at a white character that has been entered during the
    -- current insert command.
    l = true,
    v = true, -- vi breaking
}

o.linebreak = true

--------------------------------------------------------------------------------//
-- Search {{{1
--------------------------------------------------------------------------------//

opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

--------------------------------------------------------------------------------//
-- Backups {{{1
--------------------------------------------------------------------------------//

opt.swapfile                = false
opt.backup                  = false
opt.undodir                 = vim.fn.expand("$HOME/.vim/undodir")

--------------------------------------------------------------------------------//
-- Spelling {{{1
--------------------------------------------------------------------------------//
opt.spell         = true
opt.spelllang     = 'en_us'
opt.spellcapcheck = ""
opt.spelloptions:append('camel')

--------------------------------------------------------------------------------//
-- Folding {{{1
--------------------------------------------------------------------------------//

-- Fixes some jank
o.foldlevelstart = 999
opt.foldlevel = 999

o.foldenable = true
opt.foldmethod = 'marker'
opt.foldtext = ""

-- }}}

