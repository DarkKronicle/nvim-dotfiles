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
    opts = {
        auto_save_trailblazer_state_on_exit = true,
        auto_load_trailblazer_state_on_enter = true,
        custom_session_storage_dir = aelius.get_data_path() .. '/trail_blazer_sessions',
        force_mappings = {
            nv = {
                motions = {
                    new_trail_mark = '<leader><leader>',
                    track_back = '<leader>b',
                    peek_move_next_down = '<leader>j',
                    peek_move_previous_up = '<leader>k',
                    move_to_nearest = '<A-n>',
                    toggle_trail_mark_list = '<A-i>',
                },
                actions = {
                    delete_all_trail_marks = '<A-L>',
                    paste_at_last_trail_mark = '<A-p>',
                    paste_at_all_trail_marks = '<A-P>',
                    set_trail_mark_select_mode = '<A-t>',
                    switch_to_next_trail_mark_stack = '<A-.>',
                    switch_to_previous_trail_mark_stack = '<A-,>',
                    set_trail_mark_stack_sort_mode = '<A-s>',
                },
            }
        }
    },
})
