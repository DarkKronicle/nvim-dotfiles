local conf = require("modules.writing.config")
local writing = require("core.pack").package


writing({
    "nvim-neorg/neorg",
    ft = { "norg" },
    cmd = { "Neorg" },
    dependencies = {
        -- "3rd/image.nvim",
        {
            "jarvismkennedy/neorg-roam.nvim",
            cond = true,
            branch = "dev",
            dependencies = {
                "nvim-telescope/telescope.nvim",
                "nvim-lua/plenary.nvim",
            },
        },
        "nvim-neorg/neorg-telescope",
    },
    build = ":Neorg sync-parsers",
    opts = require("modules.writing.neorg.config").opts,
    config = require("modules.writing.neorg.config").config,
})


