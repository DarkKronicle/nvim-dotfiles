return {
    {
        'jedrzejboczar/possession.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function ()
            require('telescope').load_extension('possession')
            require('possession').setup{
                autosave = {
                    current = true,
                    tmp = true,
                }
            }
        end
    },
}
