local conf = require("modules.writing.config")
local writing = require("core.pack").package


writing({
    "nvim-neorg/neorg",
    ft = { "norg" },
    cmd = { "Neorg" },
    dependencies = {
        -- "3rd/image.nvim",
        {
            "jarvismkennedy/neorg-roam.nvim",
            cond = true,
            branch = "dev",
            dependencies = {
                "nvim-telescope/telescope.nvim",
                "nvim-lua/plenary.nvim",
            },
        },
        "nvim-neorg/neorg-telescope",
    },
    build = ":Neorg sync-parsers",
    opts = require("modules.writing.neorg.config").opts,
    config = require("modules.writing.neorg.config").config,
})

writing({
    'nvim-neorg/neorg-telescope',
})

writing({
    'preservim/vim-pencil',
    cmd = {
        'Pencil', 'NoPencil', 'PencilOff',
        'TogglePencil', 'PencilToggle',
        'SoftPencil', 'PencilSoft',
        'HardPencil', 'PencilHard'
    },
    init = function()
        vim.g["pencil#wrapModeDefault"] = "soft"
    end,
})

writing({
    '3rd/image.nvim',
    ft = { 'markdown', 'norg' },
    opts = {
        backend = 'kitty',
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
    },
    config = function(_, opts)
        aelius.add_package_path(vim.fn.expand("$HOME" .. "/.luarocks/share/lua/5.1"))
        require("image").setup(opts)
    end,

})
