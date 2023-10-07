return {
    {'BurntSushi/ripgrep'},
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'debugloop/telescope-undo.nvim'
        },
        keys = {
            {
                '<leader>pf',
                require('legendary.toolbox').lazy_required_fn('telescope.builtin', 'find_files'),
                mode = 'n',
                desc = 'Telescope fuzzy find files',
            },
            {
                '<leader>pp',
                require('legendary.toolbox').lazy_required_fn('telescope.builtin', 'git_files'),
                mode = 'n',
                desc = 'Telescope fuzzy find git files',
            },
            -- {
            --     '<leader>ps',
            --     function ()
            --         require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > " )})
            --     end,
            --     mode = 'n',
            --     desc = 'Telescope grep files',
            -- },
            {
                '<leader>u',
                function ()
                    require("telescope").extensions.undo.undo()
                end,
                desc = 'Telescope open undo'
            }

        },
        config = function ()
            require('telescope').setup({
                extensions = {
                    fzf = {
                        override_generic_sorter = true
                    }
                }
            })
            require('telescope').load_extension('fzf')
            require("telescope").load_extension("undo")
        end
    },
    {
        'fdschmidt93/telescope-egrepify.nvim',
        keys = {
            {
                '<leader>ps',
                function ()
                    require('telescope').extensions.egrepify.egrepify {}
                end,
                desc = 'egrepify',
                mode = 'n'
            },
            {
                '<leader>ps',
                function ()
                    -- https://github.com/nvim-telescope/telescope.nvim/blob/8c69f58427f98b2ca39a90a36db830c06e30351c/lua/telescope/builtin/__files.lua#L195
                    local saved_reg = vim.fn.getreg "v"
                    vim.cmd [[noautocmd sil norm "vy]]
                    local selection = vim.fn.getreg "v"
                    vim.fn.setreg("v", saved_reg)
                    require('telescope').extensions.egrepify.egrepify { search = selection }
                    print(selection)
                    vim.api.nvim_feedkeys(selection, "n", true)
                end,
                desc = 'egrepify',
                mode = 'v'
            },
        },
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function ()
            require('telescope').load_extension('egrepify')
        end
    }
}
