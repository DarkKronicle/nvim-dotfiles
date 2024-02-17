return {
    {
        '3rd/image.nvim',
        ft = {'markdown', 'norg'},
        enabled = not vim.g.started_by_firenvim,
        config = function ()
            require('image').setup({
                backend = 'kitty',
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },

            })
        end
    },
}
