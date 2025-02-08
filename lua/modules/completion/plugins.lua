-- TODO:
-- nvim-scissors (custom snippets)
-- snippet keybinds need to be refined, should be able to use defaults


local conf = require("modules.completion.config")
local completion = require("core.pack").package

completion({
    "saghen/blink.cmp",
    dependencies = {
        { "hrsh7th/cmp-emoji" },
        { "chrisgrieser/cmp_yanky" },
        { "kdheepak/cmp-latex-symbols", lazy = true },
        { "L3MON4D3/LuaSnip" },
    },
    opts = {
        keymap = { 
            preset = "super-tab",
            ["<c-g>"] = {
                function()
                    -- invoke manually, requires blink >v0.8.0
                    require("blink-cmp").show({ providers = { "ripgrep" } })
                end,
            },
        },
        snippets = { preset = 'luasnip' },
        signature = {
            enabled = true,
            window = {
                winblend = 10,
            },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = {
                    winblend = 10,
                },
            },
            menu = {
                winblend = 10,
                draw = {
                    treesitter = { 'lsp' },
                }
            },
            ghost_text = {
                enabled = true
            }
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji', 'yanky', 'latex'},
            providers = {
                emoji = {
                    name = "emoji",
                    score_offset = -3,
                    module = 'blink.compat.source',
                },
                yanky = {
                    name = "cmp_yanky",
                    module = 'blink.compat.source',
                },
                latex = {
                    name = "lua-latex-symbols",
                    score_offset = -3,
                    module = 'blink.compat.source',
                },
                ripgrep = {
                    module = "blink-ripgrep",
                    name = "Ripgrep",
                    score_offset = -1,
                },
                buffer = {
                    opts = {
                        get_bufnrs = function()
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == ''
                            end, vim.api.nvim_list_bufs())
                        end
                    }
                }

            }
        }
    },
    opts_extend = { "sources.default" }
})

completion({
    'saghen/blink.compat',
})

completion({
    "mikavilpas/blink-ripgrep.nvim"
})

completion({
    "L3MON4D3/LuaSnip",
    name = "luasnip",
    build = require("core.nixCatsUtils").ifNixCats(nil, "make install_jsregexp"),
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
