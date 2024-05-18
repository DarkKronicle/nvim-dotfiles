local conf = require("modules.treesitter.config")
local ts = require("core.pack").package

ts({
    "nvim-treesitter/nvim-treesitter",
    build = require("core.nixCatsUtils").ifNixCats(nil, ":TSUpdate"),
    config = conf.nvim_treesitter,
    dependencies = require("core.nixCatsUtils").ifNixCats(nil, {
        "nushell/tree-sitter-nu"
    }),
})


