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
                leader_key = ";j",
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
        enabled = false,
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
    },
    {
        'karb94/neoscroll.nvim',
        config = function()

            require('neoscroll').setup({})
            local t = {}
            t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
            t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '250'}}
            t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}}
            t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450'}}
            t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
            t['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
            t['zt']    = {'zt', {'250'}}
            t['zz']    = {'zz', {'250'}}
            t['zb']    = {'zb', {'250'}}

            require('neoscroll.config').set_mappings(t)
        end

    },
    {
        'drybalka/tree-climber.nvim',
        keys = {
            {
                'J',
                function ()
                    require('tree-climber').goto_next()
                end,
                mode = { "n" },
                desc = "Goto next node"
            },
            {
                'K',
                function ()
                    require('tree-climber').goto_prev()
                end,
                mode = { "n" },
                desc = "Goto next node"
            },
            {
                'L',
                function ()
                    require('tree-climber').goto_child()
                end,
                mode = { "n" },
                desc = "Goto child node"
            },
            {
                'H',
                function ()
                    require('tree-climber').goto_parent()
                end,
                mode = { "n" },
                desc = "Goto parent node"
            },
        },
    },
    {
        'j-morano/buffer_manager.nvim',
        keys = {
            {
                ';f',
                function ()
                    require("buffer_manager.ui").toggle_quick_menu()
                end,
                'Open buffer manager'
            }
        },
        config = function ()
            require('buffer_manager').setup({})
        end
    },
    {
        'chrisgrieser/nvim-various-textobjs',
        lazy = false,
        opts = { useDefaultKeymaps = false },
    },
    {
        'gbprod/yanky.nvim',
        lazy = false,
        config = function ()
            require('yanky').setup({
                system_clipboard = {
                    sync_with_ring = true,
                },
                highlight = {
                    on_put = true,
                    on_yank = true,
                    timer = 200,
                },
            })
            require('telescope').load_extension('yank_history')
        end
    },
    {
        'Wansmer/treesj',
        keys = {
            {
                "<leader>m",
                "<cmd>lua require('treesj').toggle()<cr>",
                desc = "Toggle join tree",
            },
        },
        config = function ()
            require('treesj').setup({
                use_default_keymaps = false,
            })
        end

    }
}
