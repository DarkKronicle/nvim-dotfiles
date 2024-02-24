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

ui({
    'famiu/bufdelete.nvim',
    lazy = true,
    cmd = { 'Bdelete', 'Bwipeout' },
})

ui({
    "rebelot/heirline.nvim",
    event = "BufEnter",
    dependencies = { 
        "Zeioth/heirline-components.nvim",
        "lewis6991/gitsigns.nvim",
    },
    config = conf.heirline,
})

ui({
    "folke/noice.nvim",
    enabled = not vim.g.started_by_firenvim,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function ()
        -- https://github.com/rafi/vim-config/blob/master/lua/rafi/plugins/ui.lua
        require("notify").setup({
            background_colour = "#00000000"
        })

        require("noice").setup({
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
                override = {
                },
                progress = {
                    enabled = false
                }
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,     -- use a classic bottom cmdline for search
                command_palette = true,   -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                lsp_doc_border = false,   -- add a border to hover docs and signature help
                inc_rename = true,
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true },
                },
                {
                    filter = { event = 'notify', find = '^No information available$' },
                    opts = { skip = true },
                },
                {
                    filter = { event = 'msg_show', find = '^%d+ change;' },
                    opts = { skip = true },
                },
                {
                    filter = { event = 'msg_show', find = '^%d+ %a+ lines' },
                    opts = { skip = true },
                },
                {
                    filter = { event = 'msg_show', find = '^%d+ lines yanked$' },
                    opts = { skip = true },
                },
            },
        })
    end
})

