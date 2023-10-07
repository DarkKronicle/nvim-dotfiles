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
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "/media/peroroncino/documents/neorg/main",
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
}
