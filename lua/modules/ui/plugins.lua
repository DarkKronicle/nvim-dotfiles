local conf = require("modules.ui.config")
local ui = require("core.pack").package

ui({
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",
    },
    config = conf.neotree,
    keys = {
        {
            '<leader>t',
            '<cmd>Neotree position=left reveal<cr>',
        }
    }
})

ui({
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    config = conf.yazi,
    keys = {
        {
            "<leader>pd",
            function()
                require("yazi").yazi()
            end,
            desc = "Open yazi at current file",
        },
    },
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


ui({
    'chentoast/marks.nvim',
    opts = {
        default_mappings = true,
    },
})

ui({
    'tzachar/highlight-undo.nvim',
    opts = {},
})

ui({
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
})

ui({
    "lewis6991/gitsigns.nvim",
    event = 'VeryLazy',
    opts = {
        signs = {
            -- TODO: I have no idea which one's I prefer
            -- add          = { text = '│' },
            -- change       = { text = '│' },
            -- delete       = { text = '_' },
            -- topdelete    = { text = '‾' },
            -- changedelete = { text = '~' },
            -- untracked    = { text = '┆' },
            add          = { text = '+' },
            change       = { text = '+' },
            delete       = { text = '-' },
            topdelete    = { text = '-' },
            changedelete = { text = '~' },
            untracked    = { text = ':' },
        },
    },
})

ui({
    -- TODO: Probably should disable this on large buffers
    "RRethy/vim-illuminate",
    event = 'VeryLazy',
    config = function (_, opts)
        require('illuminate').configure(opts)
    end,
    opts = {
        providers = {
            'lsp',
            'treesitter',
            'regex',
        }
    }

})

ui({
    -- TODO: Probably should disable this on large buffers
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = 'VeryLazy',
    opts = {
        providers = {
            'lsp',
            'treesitter',
            'regex',
        }
    }
})

ui({
    "echasnovski/mini.hipatterns",
    config = function()
        local hipatterns = require('mini.hipatterns')
        hipatterns.setup({
            highlighters = {
                hex_color = hipatterns.gen_highlighter.hex_color(),
            }
        })
    end
})

ui({
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    opts = {},
})

ui({
    -- TODO: what to do about this?
    "mvllow/modes.nvim",
    cond = false,
    init = function ()
        vim.o.cursorline = true
    end,
    opts = {

    }
})

ui({
    "stevearc/dressing.nvim",
    config = true,
})

ui({
    "mrjones2014/smart-splits.nvim",
    keys = conf.smartsplits_keys,
    config = true,
})
 
-- TODO: Add actual yazi nvim plugin

-- Defaults look quite nice (pretty sure I use catppuccin to modify it slightly too)
ui({
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {}
})


ui({
    'pocco81/true-zen.nvim',
    lazy = false,
    opts = {
        integrations = {
            twilight = true,
        }
    }
})

ui({
    'folke/twilight.nvim',
    cmd = 'Twilight',
    opts = {
        context = 20,
    }
})

ui({
    'echasnovski/mini.animate',
    config = conf.animate,
})

ui({
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    config = function()
        require('kitty-scrollback').setup()
    end,
})
