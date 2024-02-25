local home = os.getenv("HOME")

function aelius.get_config_path()
    -- TODO: move this over
    return home .. "/.config/nvim"
end

function aelius.get_data_path()
    return home .. "/.local/share/nvim"
end

function aelius.get_config_file()
    return aelius.get_config_path() .. "/init.lua"
end

function aelius.get_lazy_path()
    -- TODO move this over as well
    return aelius.get_data_path() .. "/lazy2"
end
