return {
    'DarkKronicle/anime.nvim',
    dir = vim.fn.expand('$HOME/programming/lua/anime.nvim/'),
    enabled = false,
    event = 'VeryLazy',
    dependencies = {
        '3rd/image.nvim'
    },
    config = function ()
        require('anime').setup({})
    end
}
