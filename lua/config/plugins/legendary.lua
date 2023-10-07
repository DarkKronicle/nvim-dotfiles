return {
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    opts = {
        lazy_nvim = { auto_register = true }
    },
    keys = {
        {
            '<leader>cc',
            '<CMD>Legendary keymaps<cr>',
            mode = {'n'},
            desc = 'Legendary keymaps'
        }
    }
}
