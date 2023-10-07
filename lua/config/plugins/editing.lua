-- I have an issue with hop not being loaded correctly :/
local hop_loaded = false

return {
    {
        'liangxianzhe/nap.nvim',
        lazy = false,
        config = function ()
            local nap = require('nap')
            nap.setup({
                next_prefix = "]",
                prev_prefix = "["
            })
        end
    },
    {
        'chrisgrieser/nvim-spider',
        lazy = false,
        config = function ()
            require("spider").setup({
                skipInsignificantPunctuation = true
            })

            vim.keymap.set({"n", "o", "x"}, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
            vim.keymap.set({"n", "o", "x"}, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
            vim.keymap.set({"n", "o", "x"}, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
            vim.keymap.set({"n", "o", "x"}, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
        end
    },
    {
        -- Makes it so deleting doesn't automatically go into buffer
        'gbprod/cutlass.nvim',
        lazy = false,
        keys = {
            {
                'q',
                'd',
                desc = 'cut',
                mode = { 'v', 'n' },
                remap = false
            },
            {
                'qq',
                'd_',
                desc = 'cut current line',
                remap = false
            }
        },
        opts = {

        }
    },
    {
        "danymat/neogen",
        lazy = true
    },
    {
        'smoka7/hop.nvim',
        keys = {
            {
                's',
                function()
                    if not hop_loaded then
                        require('hop').setup({})
                        hop_loaded = true
                    end
                    require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR })
                end,
                mode = {'n', 'o'},
                desc = 'Hop find 1 character forward',
            },
            {
                'S',
                function()
                    if not hop_loaded then
                        require('hop').setup({})
                        hop_loaded = true
                    end
                    require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR })
                end,
                mode = {'n', 'o'},
                desc = 'Hop find 1 character backward',
            },
            {
                ',s',
                function()
                    if not hop_loaded then
                        require('hop').setup({})
                        hop_loaded = true
                    end
                    require('hop').hint_char2({ direction = require('hop.hint').HintDirection.AFTER_CURSOR })
                end,
                mode = {'n', 'o'},
                desc = 'Hop find 2 character forward',
            },
            {
                ',S',
                function()
                    if not hop_loaded then
                        require('hop').setup({})
                        hop_loaded = true
                    end
                    require('hop').hint_char2({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR })
                end,
                mode = {'n', 'o'},
                desc = 'Hop find 2 character backward',
            },
            {
                ',w',
                function()
                    if not hop_loaded then
                        require('hop').setup({})
                        hop_loaded = true
                    end
                    require('hop').hint_camel_case({ direction = require('hop.hint').HintDirection.AFTER_CURSOR })
                end,
                mode = {'n', 'o'},
                desc = 'Hop find word forward',
            },
            {
                ',W',
                function()
                    if not hop_loaded then
                        require('hop').setup({})
                        hop_loaded = true
                    end
                    require('hop').hint_camel_case({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR })
                end,
                mode = {'n', 'o'},
                desc = 'Hop find word backward',
            },
            {
                'f',
                function()
                    if not hop_loaded then
                        require('hop').setup({})
                        hop_loaded = true
                    end
                    require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true})
                end,
                mode = {'n', 'o'},
                desc = 'Override default find',
            },
            {
                'F',
                function()
                    if not hop_loaded then
                        require('hop').setup({})
                        hop_loaded = true
                    end
                    require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true})
                end,
                mode = {'n', 'o'},
                desc = 'Override default find',
            },
            opts = {}
        },
    },
    {
        'ThePrimeagen/harpoon',
        lazy = true,
        keys = {
            {
                '<leader>a',
                function ()
                    require('harpoon.mark').add_file()
                end,
                mode = 'n',
                desc = "Harpoon add file",
            },
            {
                '<leader>e',
                function ()
                    require('harpoon.ui').toggle_quick_menu()
                end,
                mode = 'n',
                desc = "Harpoon toggle quick menu",
            },
            {
                '<leader>1',
                function ()
                    require('harpoon.ui').nav_file(1)
                end,
                mode = 'n',
                desc = "Harpoon entry 1",
            },
            {
                '<leader>2',
                function ()
                    require('harpoon.ui').nav_file(2)
                end,
                mode = 'n',
                desc = "Harpoon entry 2",
            },
            {
                '<leader>3',
                function ()
                    require('harpoon.ui').nav_file(3)
                end,
                mode = 'n',
                desc = "Harpoon entry 3",
            },
            {
                '<leader>4',
                function ()
                    require('harpoon.ui').nav_file(4)
                end,
                mode = 'n',
                desc = "Harpoon entry 4",
            },
        },
    },
    {
        "windwp/nvim-autopairs",
        config = function() 
            require("nvim-autopairs").setup {}
        end
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            -- See :h comment.plugmap
            {
                "<C-/>",
                '<Plug>(comment_toggle_linewise_current)',
                mode = {'n'},
                desc = "Comment line by line in visual mode"
            },
            {
                "<C-/>",
                '<Plug>(comment_toggle_linewise_visual)',
                mode = {'v'},
                desc = "Comment line by line in visual mode"
            },
            {
                "<C-?>",
                '<Plug>(comment_toggle_blockwise_visual)',
                mode = {'v'},
                desc = "Comment blockwise in visual mode"
            },
        },
        config = function()
            require('Comment').setup({
                mappings = false
            })
        end
    },
    {
        'Exafunction/codeium.nvim',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        event = 'VeryLazy',
        config = function ()
            require('codeium').setup({})
        end
    },
    {
        'preservim/vim-pencil',
        cmd = {"SoftPencil", "Pencil", "HardPencil"}
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        keys = {
            {
                'ys',
                '<Plug>(nvim-surround-normal)',
                mode = 'n',
                desc = 'Surround movement'
            },
            {
                'yss',
                '<Plug>(nvim-surround-normal-cur)',
                mode = 'n',
                desc = 'Surround current line only'
            },
            {
                'ySS',
                '<Plug>(nvim-surround-normal-line)',
                mode = 'n',
                desc = 'Surround around current line'
            },
            -- {
            --     'ys',
            --     '<Plug>(nvim-surround-visual)',
            --     mode = 'v',
            --     desc = 'Surround visual selection'
            -- },
            {
                'ySS',
                '<Plug>(nvim-surround-normal-line)',
                mode = 'n',
                desc = 'Surround around current line'
            },
            {
                'cs',
                '<Plug>(nvim-surround-change)',
                mode = 'n',
                desc = 'Surround change'
            },
            {
                'rs',
                '<Plug>(nvim-surround-delete)',
                mode = 'n',
                desc = 'Surround delete'
            },
        },
        config = function()
            require("nvim-surround").setup({
                keymaps = {
                    insert = nil, insert_line = nil, normal = nil, normal_cur = nil,
                    normal_line = nil, normal_cur_line = nil, visual = nil,
                    visual_line = nil, delete = nil, change = nil,
                }
            })
        end
    },
    {
        'junegunn/vim-easy-align',
        keys = {
            {
                'ga',
                '<Plug>(EasyAlign)',
                mode = {'n', 'v'},
                desc = 'Easy align text',
            },
        }
    },
    {
        "sustech-data/wildfire.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("wildfire").setup()
        end,
    },
    {
        'hinell/move.nvim',
        keys = {
            {
                'J',
                '<CMD>MoveLine 1<CR>',
                desc = 'Move line down one',
                mode = {'n'}
            },
            {
                'K',
                '<CMD>MoveLine -1<CR>',
                desc = 'Move line up one',
                mode = {'n'}
            },
            {
                'J',
                ":'<,'>MoveBlock 1<CR>",
                desc = 'Move visual selection down one',
                mode = {'v'}
            },
            {
                'K',
                ":'<,'>MoveBlock -1<CR>",
                desc = 'Move visual selection up one',
                mode = {'v'}
            },
        }
    }
}
