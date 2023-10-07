return {
    {
        'pocco81/true-zen.nvim',
        lazy = true,
        keys = {
            {
                '<leader>za',
                '<CMD>TZAtaraxis<CR>',
                'Zen: ataraxis'
            }
        },
        opts = {
            integrations = {
                lualine = true
            }
        }
    }
}
