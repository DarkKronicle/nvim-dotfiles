local conf = require("modules.lsp.config")
local lsp = require("core.pack").package

-- TODO: move
-- require("mipsy").setup()
-- make a custom lspconfig
local lspconfig = require('lspconfig')
require('lspconfig.configs').mipsy_editor_features = {
    default_config = {
        cmd = { vim.fn.expand('~/src/mipsy-editor-features/vim-out/mipsy-lsp.sh') },
        filetypes = { 'asm' },
        root_dir = lspconfig.util.root_pattern('(*.asm)|(*.s)'),
        single_file_support = true,
        settings = {},
    };
}

-- indentation config
local indentGroup = vim.api.nvim_create_augroup("MipsIndentation", { clear = true })
vim.api.nvim_create_autocmd(
    { 'FileType' },
    {
        pattern = 'mips',
        command = 'setlocal shiftwidth=8 tabstop=8 noexpandtab',
        group = indentGroup
    }
)

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
    "rachartier/tiny-code-action.nvim",
    event = "LspAttach",
    config = function () 
        require('tiny-code-action').setup({
            backend = "delta",

        })
    end,
    keys = {
        {
            "<M-CR>",
            function ()
                require('tiny-code-action').code_action()
            end,
            desc = 'Code Action',
        }
    }

})

lsp({
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    -- Handled by nix now
    cond = false,
    opts = {
        install_root_dir = aelius.get_data_path() .. "/mason2",
    }
})

lsp({
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cond = false,
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
        automatic_installation = true,
        handlers = {
            function(name)
                -- TODO: probably move this
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
