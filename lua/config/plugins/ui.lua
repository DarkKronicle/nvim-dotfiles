return {
    {
        'petertriho/nvim-scrollbar',
        event = "VeryLazy",
        config = function()
            require("scrollbar").setup()
        end
    },
    {'NvChad/nvim-colorizer.lua'},
    {
        "lukas-reineke/indent-blankline.nvim",
        main = 'ibl',
        opts = {
            scope = {
                enabled = true,
            }
        }
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        config = function ()
            local rainbow_delimiters = require('rainbow-delimiters')

            require 'rainbow-delimiters.setup'.setup({
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    commonlisp = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    latex = 'rainbow-blocks',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            })
        end
    },
    {
        'RRethy/vim-illuminate',
        eanble = false,
        config = function()
            require('illuminate').configure({
                providers = {
                    'lsp',
                    'treesitter',
                    'regex',
                },
                delay = 100,
                filetype_overrides = {},
                filetypes_denylist = {
                    'dirvish',
                    'fugitive',
                },
                filetypes_allowlist = {},
                modes_denylist = {},
                modes_allowlist = {},
                providers_regex_syntax_denylist = {},
                providers_regex_syntax_allowlist = {},
                under_cursor = true,
                large_file_cutoff = nil,
                large_file_overrides = nil,
                min_count_to_highlight = 1,
            })
        end
    },
    {'m-demare/hlargs.nvim'},
    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup({
                build_position_cb = function(plist, _, _, _)
                    require("scrollbar.handlers.search").handler.show(plist.start_pos)
                end,
            })

            vim.cmd([[
            augroup scrollbar_search_hide
            autocmd!
            autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
            augroup END
            ]])
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
            require("scrollbar.handlers.gitsigns").setup()
        end
    },
    {
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
    },
    {
        'Aasim-A/scrollEOF.nvim',
        config = function ()
            require('scrollEOF').setup({
                insert_mode = true
            })
        end
    },
    {
        'tzachar/highlight-undo.nvim',
        config = function ()
            require('highlight-undo').setup({
                duration = 300,
                undo = {
                    hlgroup = 'HighlightUndo',
                    mode = 'n',
                    lhs = 'u',
                    map = 'undo',
                    opts = {}
                },
                redo = {
                    hlgroup = 'HighlightUndo',
                    mode = 'n',
                    lhs = '<C-r>',
                    map = 'redo',
                    opts = {}
                },
                highlight_for_count = true,
            })
        end
    },
    {
        'stevearc/dressing.nvim',
        config = function ()
            require('dressing').setup({
                select = {
                    get_config = function(opts)
                        if opts.kind == 'legendary.nvim' then
                            return {
                                telescope = {
                                    -- sorter = require('telescope.sorters').get_generic_fuzzy_sorter()
                                }
                            }
                        else
                            return {}
                        end
                    end
                }
            })
        end
    },
    {
        'folke/twilight.nvim',
        cmd = {'Twilight', 'TwilightEnable', 'TwilightDisable'},
        opts = {
            context = 20,
            dimming = {
                alpha = 0.5
            }
        }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = 'VeryLazy',
        opts = {

        }
    },
    {
        'edluffy/specs.nvim',
        event = 'VeryLazy',
        config = function ()
            require('specs').setup{
                popup = {
                    delay_ms = 0, -- delay before popup displays
                    inc_ms = 30, -- time increments used for fade/resize effects 
                    blend = 50, -- starting blend, between 0-100 (fully transparent), see :h winblend
                    width = 20,
                    winhl = "PMenu",
                    fader = require('specs').linear_fader,
                    resizer = require('specs').shrink_resizer
                },
            }
        end

    },
    {
        'famiu/bufdelete.nvim',
        keys = {
            {
                'dx',
                '<cmd>Bdelete<CR>',
                mode = 'n',
                desc = 'Close tab',
            }
        }
    },
    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        config = function()
            require('marks').setup({
                default_mappings = true,
            })
        end
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        keys = {
            {
                'zR',
                function ()
                    require('ufo').openAllFolds()
                end,
                desc = "Open all folds"
            },
            {
                'zM',
                function ()
                    require('ufo').closeAllFolds()
                end,
                desc = "Close all folds"
            },
        },
        event = "VeryLazy",
        options = {
            provider_selector = function(bufnr, filetype, buftype)
                return {'treesitter', 'indent'}
            end
        },
        config = function(_, opts)
            -- This piece in the config right here
            require("ufo").setup(opts)
        end
    },
    {
        'luukvbaal/statuscol.nvim',
        lazy = false,
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                segments = {
                    { text = { "%s" }, click = "v:lua.ScSa" },
                    { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                    {
                        text = { " ", builtin.foldfunc, " " },
                        condition = { builtin.not_empty, true, builtin.not_empty },
                        click = "v:lua.ScFa"
                    },
                }
            })
        end
    },
    {
        'kmonad/kmonad-vim',
    },
}
