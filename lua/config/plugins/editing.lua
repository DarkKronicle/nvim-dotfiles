-- I have an issue with hop not being loaded correctly :/
local hop_loaded = false

return {
    {
        'LunarVim/bigfile.nvim',
        lazy = false,
    },
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
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    {
        'otavioschwanck/arrow.nvim',
        event = 'VeryLazy',
        config = function() 
            require("arrow").setup({
                show_icons = true,
                leader_key = ";",
            })
        end
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
