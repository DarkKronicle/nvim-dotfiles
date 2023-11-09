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
                    -- ["core.ui.calendar"] = {},
                },
            }
        end
    },
    {
        "RutaTang/quicknote.nvim",
        enabled = false,
        config = function()
            require("quicknote").setup({
                mode = "portable", -- "portable" | "resident", default to "portable"
                sign = "N",    -- This is used for the signs on the left side (refer to ShowNoteSigns() api).
                -- You can change it to whatever you want (eg. some nerd fonts icon), 'N' is default
                filetype = "norg",
                git_branch_recognizable = true, -- If true, quicknote will separate notes by git branch
                -- But it should only be used with resident mode,  it has not effect used with portable mode
            })
        end
        ,
        dependencies = { "nvim-lua/plenary.nvim" }
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
                vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
                vim.api.nvim_buf_set_keymap(0, "n", "v", "<C-v>", {noremap = true})
            end, {})
        end
    }
}
