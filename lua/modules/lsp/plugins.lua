local conf = require("modules.lsp.config")
local lsp = require("core.pack").package


-- The 3 most important LSP plugins
lsp({
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        local lspconf = require("modules.lsp.lsp.mason.lsp_servers")
        lspconf()
    end,
    dependencies = {
        {
            "folke/neodev.nvim",
            ft = "lua",
            opts = { library = { plugins = { "nvim-dap-ui" } } },
        },
        {
            "folke/neoconf.nvim",
            cmd = { "Neoconf" },
            opts = { local_settings = ".nvim.json", global_settings = "nvim.json" },
        },
    },
})

lsp({
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    -- Handled by nix now
    enabled = false,
    opts = {
        install_root_dir = aelius.get_data_path() .. "/mason2",
    }
})

lsp({
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = false,
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
        automatic_installation = true,
        handlers = {
            function(name)
                -- Get the config, if it doesn't exist, don't set it up!
                -- We want manual intervention here.
                -- The "custom" config can just be `{}`
                local config = require("modules.lsp.lsp.mason.lsp_servers")(name)
                if config then
                    require("lspconfig")[name].setup(config)
                else
                    vim.defer_fn(function ()
                        aelius.warn("LSP " .. name .. " is not set up!")
                    end, 200)
                end
            end,
        },
    },
})

-- TODO: set up keybinds and stuff for this. This will be in after/ftplugin/rust.lua
lsp({
    "mrcjkb/rustaceanvim",
    ft = { 'rust' },
})

lsp({
    'DNLHC/glance.nvim',
    cmd = 'Glance',
    keys = conf.glance_keys,
    config = conf.glance,
})

lsp({
    'smjonas/inc-rename.nvim',
    config = function (_, opts)
        require('inc_rename').setup(opts)
    end,
    cmd = 'IncRename',
    keys = {
        '<leader>r',
        ':IncRename ',
        desc = 'Rename',
    },
})
