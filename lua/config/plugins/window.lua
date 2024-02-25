return {
    {
        'mrjones2014/smart-splits.nvim',
        keys = {
            {
                '<C-h>',
                function ()
                    require('smart-splits').move_cursor_left()
                end,
                desc = 'Smart Splits Move Cursor Left',
            },
            {
                '<C-l>',
                function ()
                    require('smart-splits').move_cursor_right()
                end,
                desc = 'Smart Splits Move Cursor Right',
            },
            {
                '<C-j>',
                function ()
                    require('smart-splits').move_cursor_down()
                end,
                desc = 'Smart Splits Move Cursor Down',
            },
            {
                '<C-k>',
                function ()
                    require('smart-splits').move_cursor_up()
                end,
                desc = 'Smart Splits Move Cursor Up',
            },
            {
                '<C-S-h>',
                function ()
                    require('smart-splits').resize_left()
                end,
                desc = 'Smart Splits Resize Left',
            },
            {
                '<C-S-l>',
                function ()
                    require('smart-splits').resize_right()
                end,
                desc = 'Smart Splits Resize Right',
            },
            {
                '<C-S-j>',
                function ()
                    require('smart-splits').resize_down()
                end,
                desc = 'Smart Splits Resize Down',
            },
            {
                '<C-S-k>',
                function ()
                    require('smart-splits').resize_up()
                end,
                desc = 'Smart Splits Resize Up',
            },
        },
        build = './kitty/install-kittens.bash',
        config = function ()
            require('smart-splits').setup()
        end
    },
    {
        'folke/edgy.nvim',
        config = function ()
            require('edgy').setup({  
                animate = {
                    enabled = false,
                },
                left = {
                    -- Neo-tree filesystem always takes half the screen height
                    {
                        title = "Neo-Tree",
                        ft = "neo-tree",
                        filter = function(buf)
                            return vim.b[buf].neo_tree_source == "filesystem"
                        end,
                        size = { height = 0.5 },
                    },
                    {
                        title = "Neo-Tree Buffers",
                        ft = "neo-tree",
                        filter = function(buf)
                            return vim.b[buf].neo_tree_source == "buffers"
                        end,
                        pinned = true,
                        open = "Neotree position=top buffers",
                    },
                    {
                        ft = "aerial",
                        pinned = true,
                        open = "AerialOpen",
                    },
                    -- any other neo-tree windows
                    "neo-tree",
                },
            })
        end
    },
    {
        'stevearc/aerial.nvim',
        config = function ()
            require('aerial').setup({
                attach_mode = "global",
                close_automatic_events = nil,
                keymaps = {
                    ["?"] = "actions.show_help",
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.jump",
                    ["<2-LeftMouse>"] = "actions.jump",
                    ["<C-v>"] = "actions.jump_vsplit",
                    ["<C-s>"] = "actions.jump_split",
                    ["p"] = "actions.scroll",
                    ["<S-j>"] = "actions.down_and_scroll",
                    ["<S-k>"] = "actions.up_and_scroll",
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                    ["{"] = "actions.prev",
                    ["}"] = "actions.next",
                    ["[["] = "actions.prev_up",
                    ["]]"] = "actions.next_up",
                    ["q"] = "actions.close",
                    ["o"] = "actions.tree_toggle",
                    ["za"] = "actions.tree_toggle",
                    ["O"] = "actions.tree_toggle_recursive",
                    ["zA"] = "actions.tree_toggle_recursive",
                    ["l"] = "actions.tree_open",
                    ["zo"] = "actions.tree_open",
                    ["L"] = "actions.tree_open_recursive",
                    ["zO"] = "actions.tree_open_recursive",
                    ["h"] = "actions.tree_close",
                    ["zc"] = "actions.tree_close",
                    ["H"] = "actions.tree_close_recursive",
                    ["zC"] = "actions.tree_close_recursive",
                    ["zr"] = "actions.tree_increase_fold_level",
                    ["zR"] = "actions.tree_open_all",
                    ["zm"] = "actions.tree_decrease_fold_level",
                    ["zM"] = "actions.tree_close_all",
                    ["zx"] = "actions.tree_sync_folds",
                    ["zX"] = "actions.tree_sync_folds",
                },
            })
        end
    },
    {
        'yorickpeterse/nvim-window',
        keys = {
            {
                "<leader>pw",
                function ()
                    require('nvim-window').pick()
                end,
                "Pick nvim-window"
            },
        },
        config = function ()
            require('nvim-window').setup({})
        end
    }
}
