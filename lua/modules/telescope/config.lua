local config = {}

function config.telescope()
    local telescope = require('telescope')
    -- I've had some weird telescope issues, so this will try to get out of insert
    local function stopinsert(callback)
        return function(prompt_bufnr)
            vim.cmd.stopinsert()
            vim.schedule(function() callback(prompt_bufnr) end)
        end
    end

    local actions = require'telescope.actions'
    -- https://github.com/ayamir/nvimdots/blob/main/lua/modules/configs/tool/telescope.lua
    telescope.setup({
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
    telescope.load_extension('fzf')
    telescope.load_extension('egrepify')
end

return config
