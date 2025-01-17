local conf = require("modules.telescope.config")
local ts = require("core.pack").package

-- Use telescope specific fzf
ts({
    'nvim-telescope/telescope-fzf-native.nvim', 
    build = require('core.nixCatsUtils').ifNixCats(nil, 'make'),
    lazy = false,
})

ts({
    'nvim-telescope/telescope.nvim',
    dependencies = { 
        { 'nvim-lua/plenary.nvim', lazy = true },
    },
    config = conf.telescope,
    cmd = 'Telescope',
    keys = {
        {
            '<leader>sp',
            function ()
                require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor({}))
            end,
            desc = 'Spell suggest menu',
            mode = 'n'
        },
        {
            '<leader>py',
            function ()
                require('telescope').extensions.yank_history.yank_history()
            end,
            desc = 'Yank history',
            mode = 'n'
        },
    },
})

-- Can also do :Telescope nerdy or require('telescope').extensions.nerdy.nerdy() after require('telescope').load_extension('nerdy')
-- But dressing makes it look nice just within Nerdy
ts({
    '2kabhishek/nerdy.nvim',
    enabled = false,
    dependencies = {
        'stevearc/dressing.nvim',
        'nvim-telescope/telescope.nvim',
    },
    cmd = 'Nerdy',
})
