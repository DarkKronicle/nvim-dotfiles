local conf = require("modules.colorscheme.config")
local cs = require("core.pack").package

cs({
    "catppuccin/nvim",
    priority = 1500,
    config = conf.catppuccin,
})
