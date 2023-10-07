return {
    {
        'nvim-treesitter/nvim-treesitter', 
        -- TODO: Resolve this
        -- There's a big slowdown on the most recent version for me, specifically with rust
        -- Has to do with #indent() #4839
        -- commit = '33eb472b459f1d2bf49e16154726743ab3ca1c6d',
        -- But without the newest version I get an error sometimes :(
        build = ':TSUpdate'
    },
    {
        -- Neovim documentation helper
        'folke/neodev.nvim',
        priority = 300,
        lazy = false,
        config = function()
            require("neodev").setup {
            }
        end
    },
    {
        'lewis6991/hover.nvim',
        lazy = true,
        keys = {
            {
                '<C-k>',
                function ()
                    require('hover').hover()
                end,
                desc = 'Hover over current object'
            }
        },
        config = function ()
            require('hover').setup({
                init = function ()
                    require('hover.providers.lsp')
                end
            })
        end
    },
    {
        'LhKipp/nvim-nu',
        ft = 'nu'
    },
    {
        keys = {
            {
                'gr',
                '<CMD>Glance references<CR>',
                mode = 'n',
                desc = 'Glance references',
            },
            {
                'gd',
                '<CMD>Glance definitions<CR>',
                mode = 'n',
                desc = 'Glance definitions',
            }
        },
        'DNLHC/glance.nvim',
        opts = {
            border = {
                enable = true
            }
        }
    },
    {
        'folke/trouble.nvim',
        cmd = {'Trouble', 'TroubleClose', 'TroubleToggle'},
        keys = {
            {
                '<leader>/',
                '<CMD>TroubleToggle<CR>',
                mode = {'n'},

            }
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'hinell/lsp-timeout.nvim',
        event = 'VeryLazy',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        config = function ()
            vim.g["lsp-timeout-config"] = {
                stopTimeout  = 1000 * 60 * 15, -- wait ms before stopping all LSP servers

                startTimeout = 1000 * 10,      -- ms before restart
                silent       = false           -- true to suppress notifications
            }
        end
    },
    {
        'kosayoda/nvim-lightbulb',
        opts = {
            sign = {
                enabled = false,
            },
            virtual_text = {
                enabled = true,
            },
            auto_cmd = {
                enabled = true
            }
        }
    },
    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
        keys = {
            {
                '<C-CR>',
                '<CMD>CodeActionMenu<CR>',
                desc = 'View code actions'
            }
        }
    },
    {
        'nvimtools/none-ls.nvim',
        config = function ()
            local null_ls = require('null-ls')
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.code_actions.gitsigns,
                    null_ls.builtins.code_actions.proselint,
                }
            })
        end
    }
}
