local conf = require("modules.latex.config")
local latex = require("core.pack").package

latex({
    'lervag/vimtex',
    lazy = false,
    init = conf.vimtex,
})
