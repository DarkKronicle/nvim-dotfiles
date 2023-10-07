return {
    'akinsho/bufferline.nvim',
    enabled = not vim.g.started_by_firenvim,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function ()
        require('bufferline').setup({
            options = {
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                }
            }
        })
    end
}
