return {
    'nvim-lualine/lualine.nvim',
    enabled = not vim.g.started_by_firenvim,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        local function wordcount ()
            local wc = vim.api.nvim_eval("wordcount()")
            if wc["visual_words"] then
                return wc["visual_words"]
            else
                return wc["words"]
            end
        end


        require("lualine").setup({
            sections = { lualine_a = {'mode'}, lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {wordcount},
                -- lualine_y = {'progress'},
                lualine_z = {'progress', 'location'}
            },
            extensions = {
                'neo-tree',
                'aerial',
                'trouble',
            },
            options = {
                theme = 'rosebones',
            },
            disabled_filetypes = {
                'aerial',
                'edgy',
            },
        })
    end
}
