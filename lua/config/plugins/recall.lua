return {
    -- 'DarkKronicle/recall.nvim',
    dir = vim.fn.expand('$HOME/programming/lua/recall.nvim/'),
    event = 'VeryLazy',
    -- enabled = false,
    keys = {
        {
            '<C-i>',
            function ()
                require('recall').jump_backwards()
            end,
            desc = 'Recall backwards through history'
        },
        {
            '<C-o>',
            function ()
                require('recall').jump_forwards()
            end,
            desc = 'Recall forwards through history'
        }
    },
    config = function ()
        require('recall').setup({})
    end
}

