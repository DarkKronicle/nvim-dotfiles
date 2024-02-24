-- a central place for color definitions
-- the catppuccin plugin has a ton of features, so for the most part
-- I plan on using color overrides instead of moving to
-- separate colorscheme plugin.

local colors = {}

-- Base colors, changing base should be done somewhat sparingly 
-- because it needs to be configured within kitty, could maybe
-- have a live-reload/override for kitty or something
colors.catppuccin_override = {
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

    -- This is from rosebones
    base = "#1A1825",
}

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
