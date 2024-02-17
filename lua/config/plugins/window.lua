return {
    {
        'mrjones2014/smart-splits.nvim',
        keys = {
            {
                '<C-h>',
                function ()
                    require('smart-splits').move_cursor_left()
                end,
                desc = 'Smart Splits Move Cursor Left',
            },
            {
                '<C-l>',
                function ()
                    require('smart-splits').move_cursor_right()
                end,
                desc = 'Smart Splits Move Cursor Right',
            },
            {
                '<C-j>',
                function ()
                    require('smart-splits').move_cursor_down()
                end,
                desc = 'Smart Splits Move Cursor Down',
            },
            {
                '<C-k>',
                function ()
                    require('smart-splits').move_cursor_up()
                end,
                desc = 'Smart Splits Move Cursor Up',
            },
            {
                '<C-S-h>',
                function ()
                    require('smart-splits').resize_left()
                end,
                desc = 'Smart Splits Resize Left',
            },
            {
                '<C-S-l>',
                function ()
                    require('smart-splits').resize_right()
                end,
                desc = 'Smart Splits Resize Right',
            },
            {
                '<C-S-j>',
                function ()
                    require('smart-splits').resize_down()
                end,
                desc = 'Smart Splits Resize Down',
            },
            {
                '<C-S-k>',
                function ()
                    require('smart-splits').resize_up()
                end,
                desc = 'Smart Splits Resize Up',
            },
        },
        build = './kitty/install-kittens.bash',
        config = function ()
            require('smart-splits').setup()
        end
    },
}
