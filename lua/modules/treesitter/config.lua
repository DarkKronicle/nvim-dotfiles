local config = {}

function config.nvim_treesitter()
    require("modules.treesitter.treesitter").treesitter()
end

return config
