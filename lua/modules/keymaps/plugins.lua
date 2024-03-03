local keymaps = require('core.pack').package
local conf = require('modules.keymaps.config')


keymaps({
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {

    }
})

-- Hydra
keymaps({
    'nvimtools/hydra.nvim',
    config = conf.hydra
})
