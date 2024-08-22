local conf = require("modules.latex.config")
local latex = require("core.pack").package

local filetype = { 'latex', 'tex' }

latex({
    'lervag/vimtex',
    -- ft = filetype,
    lazy = false,
    init = conf.vimtex
})
