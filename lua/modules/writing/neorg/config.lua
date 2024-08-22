local M = {}

M.opts = {
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.integrations.telescope"] = {},
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.latex.renderer"] = {
            config = {
                renderer = "core.integrations.image",
                conceal = true,
            }
        },
        ["core.itero"] = {},
        ["core.export"] = {},
        ["core.export.markdown"] = {
            config = {
                extensions = "all",
            },
        },

        ["core.concealer"] = {
            config = {
                icon_preset = "varied",
                icons = {
                    delimiter = {
                        horizontal_line = {
                            highlight = "@neorg.delimiters.horizontal_line",
                        },
                    },
                    code_block = {
                        -- If true will only dim the content of the code block (without the
                        -- `@code` and `@end` lines), not the entirety of the code block itself.
                        content_only = true,

                        -- The width to use for code block backgrounds.
                        --
                        -- When set to `fullwidth` (the default), will create a background
                        -- that spans the width of the buffer.
                        --
                        -- When set to `content`, will only span as far as the longest line
                        -- within the code block.
                        width = "content",

                        -- Additional padding to apply to either the left or the right. Making
                        -- these values negative is considered undefined behaviour (it is
                        -- likely to work, but it's not officially supported).
                        padding = {
                            -- left = 20,
                            -- right = 20,
                        },

                        -- If `true` will conceal (hide) the `@code` and `@end` portion of the code
                        -- block.
                        conceal = true,

                        nodes = { "ranged_verbatim_tag" },
                        highlight = "CursorLine",
                        -- render = module.public.icon_renderers.render_code_block,
                        insert_enabled = true,
                    },
                },
            },
        },
        ["core.esupports.metagen"] = {
            config = {
                type = "auto",
            },
        },
        ["core.qol.todo_items"] = {},

        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
                neorg_leader = "\\",
            },
        },
        ["core.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    compendium = "~/Documents/compendium",
                    atlas = "~/Documents/atlas",
                },
                index = "index.norg",
                autodetect = true,
                [[ -- autochdir = false, ]],
                default_workspace = "compendium",
            },
        },

        ["core.qol.toc"] = {
            config = {
                close_split_on_jump = true,
                toc_split_placement = "left",
            },
        },
        ["core.journal"] = {
            config = {
                workspace = "home",
                journal_folder = "journal",
                use_folders = true,
            },
        },
        ["core.summary"] = {},
        -- ["core.manoeuvre"] = {},
        -- ["core.ui.calendar"] = {},
        ["externals.agenda"] = {},
        ["externals.roam"] = {},
        ["externals.many-mans"] = {},
    }
}


M.config = function()
    require("neorg").setup(M.opts)
    function ToggleToc()
        if vim.bo.filetype == "norg" then
            vim.cmd("Neorg toc left")
            local current_win = vim.api.nvim_get_current_win()
            vim.api.nvim_win_set_width(current_win, 27)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>l", true, true, true), "n", true)
        end
    end

    -- Neorg
    vim.keymap.set("n", "<leader>;", ":lua ToggleToc()<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>nt", ":Neorg mode traverse-heading <cr>", {})
    vim.keymap.set("n", "<leader>nw", ":Telescope neorg_workspace_selector<cr>", {})
    vim.keymap.set("n", "<leader>nb", ":Telescope neorg_block_injector<cr>", {})
    vim.keymap.set("n", "<leader>nn", ":Telescope neorg_node_injector<cr>", {})
    vim.keymap.set("n", "<leader>ns", ":Telescope neorg_show_backlinks<cr>", {})
    vim.keymap.set("n", "<leader>nT", ":Neorg mode norg <cr>", {})

    require("modules.writing.neorg.autocommands").setup()
end

return M
