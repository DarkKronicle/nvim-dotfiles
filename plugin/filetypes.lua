-- https://neovim.io/doc/user/filetype.html
-- https://github.com/vsedov/nvim/blob/3685f3b33345fc15fca9c6d90e1e3cb34c2444fa/plugin/filetypes.lua
-- So funny thing, I was going to write my own super cool way to set cmp sources dynamically,
-- but then realized that vsedov already did it :I (and better), tho maybe it's originally from somewhere else?
-- TODO: find out who came up with this


local settings = aelius.filetype_settings

settings({
    norg = {
        plugins = {
            cmp = function(cmp)
                cmp.setup.filetype("norg", {
                    sources = {
                        { name = "path", priority = 1 },
                        { name = "luasnip", priority = 1 },
                        { name = "neorg", priority = 1 },
                        { name = "dictionary", priority = 1 },
                        { name = "spell", priority = 1 },
                        { name = "buffer", group_index = 2 },
                        { name = "emoji", group_index = 2 },
                        { name = "latex_symbols", group_index = 2 },
                    },
                })
            end,
        },
    },
})
