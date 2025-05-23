local conf = require("modules.writing.config")
local writing = require("core.pack").package

writing({
    "nvim-neorg/neorg",
    ft = { "norg" },
    cmd = { "Neorg" },
    version = "v7.0.0",
    dependencies = {
        -- { "luarocks.nvim" },
        {
            "juniorsundar/neorg-extras",
        },
        "nvim-neorg/neorg-telescope",
    },
    -- build = ":Neorg sync-parsers",
    opts = require("modules.writing.neorg.config").opts,
    config = require("modules.writing.neorg.config").config,
})

writing({
    "benlubas/neorg-interim-ls"
})

-- writing({
    -- "vhyrro/luarocks.nvim",
    -- priority = 2000, -- We'd like this plugin to load first out of the rest
    -- config = true, -- This automatically runs `require("luarocks-nvim").setup()`
-- })

writing({
    cond = false,
    'nvim-neorg/neorg-telescope',
})

writing({
    'shortcuts/no-neck-pain.nvim',
    cmd = { 'NoNeckPain' },
})

-- writing({
    -- 'jbyuki/nabla.nvim',
-- })

writing({
    '3rd/image.nvim',
    ft = { 'markdown', 'norg' },
    name = "image-nvim",
    config = function () 
        require("image").setup({
            backend = 'kitty',
            processor = "magick_rock",
            markdown = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = true,
                only_render_image_at_cursor = false,
                filetypes = { "markdown", "vimwiki" },
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

})

writing({
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    opts = {},
})
