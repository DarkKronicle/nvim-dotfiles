-- TODO:
-- cmp sometimes attacks me with about 400 options
-- nvim-scissors (custom snippets)
-- snippet keybinds need to be refined, should be able to use defaults


local conf = require("modules.completion.config")
local completion = require("core.pack").package

completion({
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-emoji" },
        { "hrsh7th/cmp-cmdline" },
        { "saadparwaiz1/cmp_luasnip", lazy = true },
        { "kdheepak/cmp-latex-symbols", lazy = true },
        {
            "doxnit/cmp-luasnip-choice",
            config = function()
                require("cmp_luasnip_choice").setup({
                    auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
                })
            end,
        },
    },
    config = conf.cmp
})

completion({
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    version = "v2.*",
    event = "InsertEnter",
    dependencies = {
        {
            "rafamadriz/friendly-snippets",
        },
        {
            "mireq/luasnip-snippets",
            cond = true,
            dependencies = { "L3MON4D3/LuaSnip" },
        },
        -- {
            -- "iurimateus/luasnip-latex-snippets.nvim",
            -- event = "VeryLazy",
            -- cond = false,
            -- dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
            -- config = true,
        -- },
    },
    config = function ()
        require("luasnip_snippets.common.snip_utils").setup()
        require("luasnip").setup({
            -- Required to automatically include base snippets, like "c" snippets for "cpp"
            load_ft_func = require("luasnip_snippets.common.snip_utils").load_ft_func,
            ft_func = require("luasnip_snippets.common.snip_utils").ft_func,
            -- To enable auto expansin
            enable_autosnippets = true,
            -- Uncomment to enable visual snippets triggered using <c-x>
            -- store_selection_keys = '<c-x>',
        })

    end
})

completion({
    "altermo/ultimate-autopair.nvim",
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6',
    opts = {
        -- help ultimate-autopair-default-config
        bs = {
            enable = true,
            space = 'balance', -- set on both sides equally
        }
    }
})

completion({
    "Exafunction/codeium.nvim",
    event = 'VeryLazy',
    -- Handled by nix now
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    opts = {},
})
