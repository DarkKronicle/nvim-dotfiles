local M = {}

local HYDRA_DIR = aelius.get_config_path() .. '/lua/modules/keymaps/hydra'
local HYDRA_MODULE = 'modules.keymaps.hydra'

function M.load_hydras()
    local found = vim.split(vim.fn.globpath(HYDRA_DIR, '*/*.lua'), '\n')
    for _, path in ipairs(found) do
        -- https://vi.stackexchange.com/a/18141
        local module = vim.fn.fnamemodify(path, ':p:h:t') .. '.' .. vim.fn.fnamemodify(path, ':t:r')
        require(HYDRA_MODULE .. '.' .. module)
    end
end

function M.load()
    -- If we want to set any defaults, #setup() hydra now
    M.load_hydras()
end

return M
