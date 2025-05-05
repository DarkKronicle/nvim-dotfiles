local conf = require("modules.lsp.config")
local lsp = require("core.pack").package

-- The 3 most important LSP plugins
lsp({
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        local lspconf = require("modules.lsp.lsp.mason.lsp_servers")
        lspconf()
    end,
})

lsp({
    "rachartier/tiny-code-action.nvim",
    name = "tiny-code-action-nvim",
    event = "LspAttach",
    config = function () 
        require('tiny-code-action').setup({
            backend = "delta",

        })
    end,
    keys = {
        {
            "<M-CR>",
            function ()
                require('tiny-code-action').code_action()
            end,
            desc = 'Code Action',
        }
    }

})

-- TODO: set up keybinds and stuff for this. This will be in after/ftplugin/rust.lua
lsp({
    "mrcjkb/rustaceanvim",
    ft = { 'rust' },
})

lsp({
    'DNLHC/glance.nvim',
    cmd = 'Glance',
    keys = conf.glance_keys,
    config = conf.glance,
})

lsp({
    'smjonas/inc-rename.nvim',
    config = function (_, opts)
        require('inc_rename').setup(opts)
    end,
    cmd = 'IncRename',
    keys = {
        '<leader>r',
        ':IncRename ',
        desc = 'Rename',
    },
})

lsp({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
            virtual_text = true,
        })
    end,
})
