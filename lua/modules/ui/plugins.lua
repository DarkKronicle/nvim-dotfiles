local conf = require("modules.ui.config")
local ui = require("core.pack").package

ui({
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        -- TODO: Lets get this going
        -- "3rd/image.nvim", 
    },
    config = conf.neotree,
    keys = {
        {
            '<leader>t',
            '<cmd>Neotree position=left reveal<cr>',
        },
        {
            '<leader>pt',
            '<cmd>Neotree position=float reveal<cr>',
        },
    }
})

