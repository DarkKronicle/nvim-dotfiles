-- Credit: https://github.com/vsedov/nvim/blob/master/lua/core/helper.lua

local helper = {}
-- Able to write on docs faster
local home = os.getenv("HOME")
helper.path_sep = package.config:sub(1, 1) == "\\" and "\\" or "/"

function helper.get_config_path()
    -- TODO: move this over
    return home .. "/.config/nvim_rewrite"
end

function helper.get_data_path()
    return home .. "/.local/share/nvim"
end

function helper.get_lazy_path()
    -- TODO move this over as well
    return helper.get_data_path() .. "/lazy2"
end

return helper
