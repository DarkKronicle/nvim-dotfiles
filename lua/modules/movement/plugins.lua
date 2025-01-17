local movement = require("core.pack").package

movement({
    "chrisgrieser/nvim-spider",
    keys = {
        {
            "e",
            "<cmd>lua require('spider').motion('e')<CR>",
            mode = { "n", "o", "x" },
		},
        {
            "w",
            "<cmd>lua require('spider').motion('w')<CR>",
            mode = { "n", "o", "x" },
		},
        {
            "b",
            "<cmd>lua require('spider').motion('b')<CR>",
            mode = { "n", "o", "x" },
		},
    },
    opts = {}
})

movement({
    "rainbowhxch/accelerated-jk.nvim",
    name = "accelerated-jk-nvim",
    keys = {
        {
            -- TODO: This will change with neorg and stuff so should do that
            'j',
            '<Plug>(accelerated_jk_j)',
            mode = 'n',
        },
        {
            'k',
            '<Plug>(accelerated_jk_k)',
            mode = 'n',
        },
    },
    config = function ()
        require("accelerated-jk").setup({})
    end
})

movement({
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
        {
            "R",
            mode = { "o", "x" },
            function() require(
                "flash"
            ).treesitter_search() end,
            desc = "Treesitter Search",
        },
        {
            "<c-s>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash Search",
        },
    }
})
