return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        keys = {
            {
                '<leader>t',
                '<CMD>Neotree<CR>',
                desc = 'Focus neotree in a pane'
            },
            {
                '<leader>pt',
                '<CMD>Neotree position=current<CR>',
                desc = 'Focus neotree as netrw'
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = true,
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true
            },
            default_component_configs = {
                icon = {
                    folder_closed = "",
                    folder_open = "",
                }
            },
            window = {
                width = 30
            },
            open_files_do_not_replace_types = { "edgy" },
        },
    },
    {
        'stevearc/oil.nvim',
        cmd = 'Oil',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            default_file_explorer = false,
            delete_to_trash = true,
        },
    }
}
