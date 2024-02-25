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
                '<leader>pb',
                require('legendary.toolbox').lazy_required_fn('telescope.builtin', 'buffers'),
                mode = 'n',
                desc = 'Telescope fuzzy find files',
            },
            {
                '<leader>pp',
                require('legendary.toolbox').lazy_required_fn('telescope.builtin', 'git_files'),
                mode = 'n',
                desc = 'Telescope fuzzy find git files',
            },
            {
                '<leader>ph',
                function ()
                    require("telescope").extensions.yank_history.yank_history()
                end,
                mode = 'n',
                desc = 'Browse yank history',
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

            local function stopinsert(callback)
                return function(prompt_bufnr)
                    vim.cmd.stopinsert()
                    vim.schedule(function() callback(prompt_bufnr) end)
                end
            end

            local actions = require'telescope.actions'
            -- local actions_fb = require'telescope'.extensions.file_browser.actions

            require('telescope').setup({
                -- https://github.com/ayamir/nvimdots/blob/main/lua/modules/configs/tool/telescope.lua
                defaults = {
                    mappings = {
                        i = {
                            ["<CR>"] = stopinsert(actions.select_default),
                        },
                    },
                    scroll_strategy = "limit",
                    layout_strategy = "horizontal",
                    path_display = { "absolute" },
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    color_devicons = true,
                    file_ignore_patterns = { ".git/", ".cache", "build/", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.85,
                        height = 0.92,
                        preview_cutoff = 120,
                    },
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

                },
                extensions = {
                    fzf = {
                        override_generic_sorter = true
                    },
                    frecency = {
                        use_sqlite = false,
                        show_scores = true,
                        show_unindexed = true,
                        ignore_patterns = { "*.git/*", "*/tmp/*" },
                    },
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
    },
    {
        'nvim-telescope/telescope-frecency.nvim',
        event = 'VeryLazy',
        keys = {
            {
                '<leader>pr',
                '<CMD>Telescope frecency<CR>',
            }
        },
        config = function ()
            require('telescope').load_extension('frecency')
        end
    }
}
