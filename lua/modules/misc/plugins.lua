local misc = require("core.pack").package

misc({
    'linrongbin16/gitlinker.nvim',
    cmd = "GitLink",
    opts = {},
    keys = {
        {
            "<leader>gy",
            "<cmd>GitLink<cr>",
            mode = { "n", "v" },
            desc = "Yank git link"
        }
    },
})

misc({
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function ()
        Snacks.toggle.profiler():map("<leader>pp")
        Snacks.toggle.profiler_highlights():map("<leader>ph")
    end,
    keys = {
        { "<leader>ps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Bufer" },
    }
})
