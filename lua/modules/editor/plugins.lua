local conf = require("modules.editor.config")
local editor = require("core.pack").package


editor({
    'gbprod/cutlass.nvim',
    event = 'VeryLazy',
    config = true,
    keys = {
        {
            'q',
            'd',
            desc = 'cut',
            mode = { 'v', 'n' },
            remap = false
        },
        {
            'qq',
            'd_',
            desc = 'cut current line',
            remap = false
        }
    }
})

editor({
    "gbprod/yanky.nvim",
    keys = {
        {
            'p',
            '<Plug>(YankyPutAfter)',
            mode = { 'n', 'x' },
            desc = 'Paste after',
        },
        {
            'P',
            '<Plug>(YankyPutBefore)',
            mode = { 'n', 'x' },
            desc = 'Paste before',
        },
        {
            'gp',
            '<Plug>(YankyGPutAfter)',
            mode = { 'n', 'x' },
            desc = 'Paste G after',
        },
        {
            'gP',
            '<Plug>(YankyGPutBefore)',
            mode = { 'n', 'x' },
            desc = 'Paste G before',
        },
        {
            '[p',
            '<Plug>(YankyPreviousEntry)',
            mode = { 'n', 'x' },
            desc = 'Previous clipboard entry',
        },
        {
            ']p',
            '<Plug>(YankyNextEntry)',
            mode = { 'n', 'x' },
            desc = 'Next clipboard entry',
        },
    },
    opts = {
        system_clipboard = {
            sync_with_ring = false,
        },
        highlight = {
            on_put = true,
            on_yank = true,
            timer = 200,
        },
    }
})

-- TODO: Integrate with theme
editor({
    'jiaoshijie/undotree',
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
        {
            '<leader>u', 
            function ()
                require('undotree').toggle()
            end,
            mode = 'n',
            desc = 'Toggle undotree'
        },
    },
    opts = {
        position = 'right',
    },
})

editor({
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
})

editor({
    "KaitlynEthylia/TreePin",
    requires = {'nvim-treesitter/nvim-treesitter'},
    keys = {
        -- TODO: Hydra
        {
            "<leader>cp",
            function ()
                require('treepin').pinLocal()
            end,
            desc = 'Pin local'
        },
        {
            "<leader>cr",
            function ()
                require('treepin').pinRoot()
            end,
            desc = 'Pin root'
        },
        {
            "<leader>cx",
            function ()
                require('treepin').pinClear()
            end,
            desc = 'Pin clear'
        },
        {
            "<leader>c]",
            function ()
                require('treepin').pinGrow()
            end,
            desc = 'Pin grow'
        },
        {
            "<leader>c[",
            function ()
                require('treepin').pinShrink()
            end,
            desc = 'Pin shrink'
        },
    },
    opts = {
        separator = "─"
    }
})
