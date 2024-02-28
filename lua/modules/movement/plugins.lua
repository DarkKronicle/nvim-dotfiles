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
    opts = {},
})

movement({
    "LeonHeidelbach/trailblazer.nvim",
    event = 'VeryLazy',
    keys = {
        {
            '<leader><leader>',
            '<cmd>lua require("trailblazer").new_trail_mark()<cr>',
            mode = { 'v', 'n' },
            desc = 'New trail mark',
        },
        {
            '<leader>b',
            '<cmd>lua require("trailblazer").track_back()<cr>',
            mode = { 'v', 'n' },
            desc = 'Trail track back',
        },
        {
            ']<leader>',
            '<cmd>lua require("trailblazer").peek_move_next_down()<cr>',
            mode = { 'v', 'n' },
            desc = 'Peek trail downwards',
        },
        {
            '[<leader>',
            '<cmd>lua require("trailblazer").peek_move_previous_up()<cr>',
            mode = { 'v', 'n' },
            desc = 'Peek trail upwards',
        },
    },
    opts = {
        auto_save_trailblazer_state_on_exit = true,
        auto_load_trailblazer_state_on_enter = true,
        custom_session_storage_dir = aelius.get_data_path() .. '/trail_blazer_sessions',
        force_mappings = {
            nv = {
                -- Handle them via lazy so we get descriptions
            }
        }
    },
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
