local conf = require("modules.telescope.config")
local ts = require("core.pack").package

-- Use telescope specific fzf
ts({ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' })

ts({
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = conf.telescope,
    keys = {
        {
            '<leader>pf',
            function ()
                require('telescope.builtin').find_files()
            end,
            mode = 'n',
            desc = 'Telescope fuzzy find files',
        },
    },
})

