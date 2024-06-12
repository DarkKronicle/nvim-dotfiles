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
        {
            "fdschmidt93/telescope-egrepify.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            lazy = true,
        },
    },
    config = conf.telescope,
    keys = {
        -- {
            -- '<leader>pf',
            -- function ()
                -- require('telescope.builtin').find_files()
            -- end,
            -- mode = 'n',
            -- desc = 'Telescope fuzzy find files',
        -- },
        {
            '<leader>ps',
            function ()
                require('telescope').extensions.egrepify.egrepify({})
            end,
            desc = 'egrepify',
            mode = 'n'
        },
        {
            '<leader>s',
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
        {
            '<leader>ps',
            function ()
                -- https://github.com/nvim-telescope/telescope.nvim/blob/8c69f58427f98b2ca39a90a36db830c06e30351c/lua/telescope/builtin/__files.lua#L195
                local saved_reg = vim.fn.getreg "v"
                vim.cmd [[noautocmd sil norm "vy]]
                local selection = vim.fn.getreg "v"
                vim.fn.setreg("v", saved_reg)
                require('telescope').extensions.egrepify.egrepify { search = selection }
                print(selection)
                vim.api.nvim_feedkeys(selection, "n", true)
            end,
            desc = 'egrepify',
            mode = 'v'
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
