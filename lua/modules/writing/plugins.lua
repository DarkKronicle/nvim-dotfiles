local conf = require("modules.writing.config")
local writing = require("core.pack").package

writing({
    "nvim-neorg/neorg",
    ft = { "norg" },
    cmd = { "Neorg" },
    version = "v7.0.0",
    dependencies = {
        "3rd/image.nvim",
        -- { "luarocks.nvim" },
        "juniorsundar/neorg_extras",
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
    'shortcuts/no-neck-pain.nvim',
    cmd = { 'NoNeckPain' },
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
    'zk-org/zk-nvim',
    keys = {
        {
            "<leader>zn",
            "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
            mode = 'n',
            desc = 'Create new note and prompt for title',
        },
        {
            "<leader>zo",
            "<Cmd>ZkNotes { sort = { 'modified' } }<CR>",
            mode = 'n',
            desc = 'Open notes',
        },
        {
            "<leader>zi",
            "<Cmd>ZkInsertLink<CR>",
            mode = 'n',
            desc = 'Insert link',
        },
        {
            "<leader>zi",
            "<Cmd>'<'>ZkInsertLinkAtSelection<CR>",
            mode = 'v',
            desc = 'Insert link',
        },
        {
            "<leader>zb",
            "<Cmd>ZkBacklinks<CR>",
            mode = 'n',
            desc = 'Open backlinks',
        },
        {
            "<leader>zl",
            "<Cmd>ZkLinks<CR>",
            mode = 'n',
            desc = 'Open backlinks',
        },
    },
    config = function()
        require("zk").setup({
            picker = "telescope"
        })
    end,
})

-- writing({
    -- 'jbyuki/nabla.nvim',
-- })

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
        require("image").setup(opts)
    end,

})
