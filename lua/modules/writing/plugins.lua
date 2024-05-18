local conf = require("modules.writing.config")
local writing = require("core.pack").package

writing({
    'epwalsh/obsidian.nvim',
    version = '*',
    ft = 'markdown',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
        require("obsidian").setup({
            workspaces = {
                {
                    name = "garden",
                    path = "~/Documents/garden"
                },
            },
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,
                -- Trigger completion at 2 chars.
                min_chars = 2,
            },
            preferred_link_style = "wiki",
            wiki_link_func = "prepend_note_path",
        })
    end
})

writing({
    cond = false,
    "nvim-neorg/neorg",
    ft = { "norg" },
    cmd = { "Neorg" },
    version = "v7.0.0",
    dependencies = {
        -- "3rd/image.nvim",
        -- { "luarocks.nvim" },
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
    -- build = ":Neorg sync-parsers",
    opts = require("modules.writing.neorg.config").opts,
    config = require("modules.writing.neorg.config").config,
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
    cond = false,
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
