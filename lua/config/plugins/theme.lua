return {
    {
        "Jint-lzxy/nvim",
        config = function ()
        end,
        priority = 1000
    },
    {
        'mcchrish/zenbones.nvim',
        priority = 999,
        dependencies = {
            "rktjmp/lush.nvim"
        },
        config = function () 
            local theme = require ("rosebones")
            local background = theme.Normal.bg;
            local rgb = background.rgb
            local bg_hex = string.format("#%x%x%x", rgb.r, rgb.g, rgb.b)

            require("catppuccin").setup({
                kitty = false,
                color_overrides = {
                    mocha = {
                        -- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-6488799
                        rosewater = "#efc9c2",
                        flamingo = "#ebb2b2",
                        pink = "#f2a7de",
                        mauve = "#b889f4",
                        red = "#ea7183",
                        maroon = "#ea838c",
                        peach = "#f39967",
                        yellow = "#eaca89",
                        green = "#96d382",
                        teal = "#78cec1",
                        sky = "#91d7e3",
                        sapphire = "#68bae0",
                        blue = "#739df2",
                        lavender = "#a0a8f6",
                        text = "#b5c1f1",
                        subtext1 = "#a6b0d8",
                        subtext0 = "#959ec2",
                        overlay2 = "#848cad",
                        overlay1 = "#717997",
                        overlay0 = "#63677f",
                        surface2 = "#505469",
                        surface1 = "#3e4255",
                        surface0 = "#2c2f40",
                        mantle = "#141620",
                        crust = "#0e0f16",

                        base = bg_hex
                    }
                },
                -- transparent_background = not vim.g.started_by_firenvim,
                show_end_of_buffer = false,
                integrations = {
                    harpoon = true,
                    aerial = true,
                    flash = true,
                    noice = true,
                    notify = true,
                    neotree = true,
                    lsp_trouble = true,
                    markdown = true,
                    treesitter = true,
                    mason = true,
                    rainbow_delimiters = true,
                    telescope = { enabled = true, style = "nvchad" },
                    cmp = true,
                    semantic_tokens = true,
                    dap = true,
                    dap_ui = true,
                },
                styles = {
                    comments = { "italic" },
                    properties = { "italic" },
                    functions = { "bold" },
                    keywords = { "italic" },
                    operators = { "bold" },
                    conditionals = { "bold" },
                    loops = { "bold" },
                    booleans = { "bold", "italic" },
                    numbers = {},
                    types = {},
                    strings = {},
                    variables = {},
                },
                highlight_overrides = {
                    all = function(cp)
                        return {
                            NormalFloat = { fg = cp.text, bg = cp.mantle },
                            FloatBorder = {
                                fg = cp.blue,
                                bg = cp.mantle,
                            },
                            Identifier = { fg = cp.rosewater },
                            CursorLineNr = { fg = cp.green },
                            IblIndent = { fg = cp.surface0 },
                            IblScope = { fg = cp.surface2, style = { "bold" } },
                            TelescopeMatching = { fg = cp.lavender },
                            TelescopeResultsDiffAdd = { fg = cp.green },
                            TelescopeResultsDiffChange = { fg = cp.yellow },
                            TelescopeResultsDiffDelete = { fg = cp.red },
                            ["@keyword.return"] = { fg = cp.pink, style = clear },
                            ["@error.c"] = { fg = cp.none, style = clear },
                            ["@error.cpp"] = { fg = cp.none, style = clear },
                        }
                    end
                }
            })
            vim.cmd('colorscheme catppuccin-mocha')
            -- vim.cmd ( '!kitty @ set-colors --to=$KITTY_LISTEN_ON --match-tab=recent:0 background=\\#' .. output )
            -- vim.fn.jobstart ( '!kitty @ set-colors --to=$KITTY_LISTEN_ON --match-tab=recent:0 background=\\#' .. output )
-- 
            -- vim.system { 'kitty', '@', 'set-colors', '--to=$KITTY_LISTEN_ON', '--match-tab=recent:0', 'background=\\#' .. output }
-- 
-- local sign = vim.fn.sign_define
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})

        end
    },
}
