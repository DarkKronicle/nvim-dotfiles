-- a central place for color definitions
-- the catppuccin plugin has a ton of features, so for the most part
-- I plan on using color overrides instead of moving to
-- separate colorscheme plugin.

local colors = {}

-- Base colors, changing base should be done somewhat sparingly 
-- because it needs to be configured within kitty, could maybe
-- have a live-reload/override for kitty or something
colors.palettes = {
    high_contrast_mocha = {
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

        base = "#16161D",
    },
    carburetor = {
        rosewater = "#ffd7d9",
        flamingo = "#ffb3b8",
        pink = "#ff7eb6",
        mauve = "#d4bbff",
        red = "#fa4d56",
        maroon = "#ff8389",
        peach = "#ff832b",
        yellow = "#fddc69",
        green = "#42be65",
        teal = "#3ddbd9",
        sky = "#82cfff",
        sapphire = "#78a9ff",
        blue = "#4589ff",
        lavender = "#be95ff",
        text = "#f4f4f4",
        subtext1 = "#e0e0e0",
        subtext0 = "#c6c6c6",
        overlay2 = "#a8a8a8",
        overlay1 = "#8d8d8d",
        overlay0 = "#6f6f6f",
        surface2 = "#525252",
        surface1 = "#393939",
        surface0 = "#262626",
        -- base = "#161616",
        base = "#000000",
        mantle = "#0b0b0b",
        crust = "#000000"
    },
}

function colors.catppuccin_override () 
    return colors.palettes.high_contrast_mocha
end

colors.catppuccin_styles = {
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
}

function colors.catppuccin_highlight_overrides(cp)
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


aelius.colors = colors
