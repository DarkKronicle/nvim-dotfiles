return {
    {
        'nvim-treesitter/nvim-treesitter', 
        lazy = false,
        build = ':TSUpdate',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        config = function()
            require('nvim-treesitter.configs').setup({
                textobjects = {
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>sa"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>sA"] = "@parameter.inner",
                        },
                    },
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                ensure_installed = {
                    'nu',
                }
            })
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

            parser_config.nu = {
                install_info = {
                    url = "https://github.com/nushell/tree-sitter-nu",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "nu",
            }

        end
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
        enabled = false,
        keys = {
            {
                '<C-k>',
                function ()
                    require('hover').hover()
                end,
                mode = {'n', 'i'},
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
        enabled = false,
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
        'aznhe21/actions-preview.nvim',
        cmd = 'CodeActionMenu',
        keys = {
            {
                '<C-CR>',
                desc = 'View code actions',
                function ()
                    require("actions-preview").code_actions()
                end
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
                    -- null_ls.builtins.code_actions.proselint,
                }
            })
        end
    },
    {
        'smjonas/inc-rename.nvim',
        keys = {
            {
                "<leader>r",
                ":IncRename ",
                desc = "Rename"
            },
        },
        config = function()
            require("inc_rename").setup()
        end,
    },
    {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        event = 'VeryLazy',
        config = function ()
            require("lsp_lines").setup()
            vim.diagnostic.config({
                -- virtual_text = false,
                virtual_lines = { 
                    only_current_line = true,
                    highlight_whole_line = false,
                },
            })
        end
    }
}
