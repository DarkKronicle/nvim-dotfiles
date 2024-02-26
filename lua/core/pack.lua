-- Credit: https://github.com/vsedov/nvim/blob/master/lua/core/pack.lua
-- Pretty cool way to handle plugins and everything
local uv, api, fn = vim.loop, vim.api, vim.fn

local pack = {}
pack.__index = pack


function pack:load_modules_packages()

    local modules_dir = aelius.get_config_path() .. "/lua/modules"
    self.repos = {}

    local get_plugin_list = function()
        local list = {}
        local tmp = vim.split(fn.globpath(modules_dir, "*/plugins.lua"), "\n")
        for _, f in ipairs(tmp) do
            -- TODO: Should it be \.lua?
            list[#list + 1] = string.match(f, "lua/(.+).lua$")
        end
        return list
    end

    local plugin_files = get_plugin_list()

    for _, m in ipairs(plugin_files) do
        require(m)
    end
    
end


function pack:boot_strap()
    local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    local state = uv.fs_stat(lazy_path)
    if not state then
        local cmd = "!git clone --filter=blob:none https://github.com/folke/lazy.nvim --branch=stable " .. lazy_path
        api.nvim_command(cmd)
    end
    vim.opt.runtimepath:prepend(lazy_path)
    local lazy = require("lazy")
    local opts = {
        -- Put lazy lock in a more central location
        lockfile = aelius.get_data_path() .. "/lazy-lock.json",
        root = aelius.get_lazy_path(),
    }
    self:load_modules_packages()
    lazy.setup(self.repos, opts)
    for k, v in pairs(self) do
        if type(v) ~= "function" then
            self[k] = nil
        end
    end
end

function pack.package(repo)
    if not pack.repos then
        pack.repos = {}
    end
    -- I forget to add keys within another table
    local keys = repo['keys']
    if keys ~= nil and type(keys) == "table" then
        for _, value in ipairs(keys) do
            if type(value) ~= "table" then
                repo.keys = { keys }
                break
            end
        end
    end

    table.insert(pack.repos, repo)
end

return pack
