_G = _G or {}

_G.aelius = {}

function _G.aelius.warn(message)
    vim.notify(message, vim.log.levels.WARN)
end

function _G.aelius.error(message)
    vim.notify(message, vim.log.levels.ERROR)
end

require("core.aelius")

