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
    opts = {}
})
