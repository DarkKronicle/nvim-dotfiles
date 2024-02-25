local conf = require("modules.lsp.config")
local lsp = require("core.pack").package


-- The 3 most important LSP plugins
lsp({
    "neovim/nvim-lspconfig",
    lazy = true,
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
    opts = {
        install_root_dir = aelius.get_data_path() .. "/mason2",
    }
})

lsp({
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
                    print("LSP " .. name .. " is not set up!")
                end
            end,
        },
    },
})

