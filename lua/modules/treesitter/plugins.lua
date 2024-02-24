local conf = require("modules.treesitter.config")
local ts = require("core.pack").package

ts({
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = conf.nvim_treesitter,
})


