return {
    {
        ft = "norg",
        cmd = "Neorg",
        "nvim-neorg/neorg",
        dependencies = "nvim-lua/plenary.nvim",
        config = function ()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {
                        config = {
                            icon_preset = 'diamond'
                        }
                    }, -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "/run/media/darkkronicle/peroroncino/documents/neorg/main",
                            },
                            index = "index.norg"
                        },
                    },
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp"
                        }
                    },
                    ["core.integrations.image"] = {},
                    ["core.latex.renderer"] = {},
                    -- ["core.ui.calendar"] = {},
                },
            }
        end
    },
    {
        "jbyuki/venn.nvim",
        config = function()
            vim.api.nvim_create_user_command('Venn', function(_)
                vim.opt_local.ve = 'all'
                vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
                vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
                vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
                vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
                vim.api.nvim_buf_set_keymap(0, "v", "f", "<CMD>VBox<CR>", {noremap = true})
                vim.api.nvim_buf_set_keymap(0, "n", "v", "<C-v>", {noremap = true})
            end, {})
        end
    },
    {
        'jbyuki/nabla.nvim',
        lazy = true,
        keys = {
            {
                "<leader>p",
                function ()
                    require('nabla').enable_virt({
                        autogen = true,
                    })
                end
            }
        }
    }
}
