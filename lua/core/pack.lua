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
    local lazy = require("core.lazyCat")
    local cat = require("core.nixCatsUtils")
    cat.setup { non_nix_value = true };
    local pluginList = nil
    local nixLazyPath = nil

    if cat.isNixCats then

        local allPlugins = require("nixCats").pawsible.allPlugins
        -- it is called pluginList because we only need to pass in the names
        pluginList = lazy.mergePluginTables( allPlugins.start, allPlugins.opt)
        -- it wasnt detecting these because the names are slightly different.
        -- when that happens, add them to the list, then also specify name in the lazySpec
        pluginList[ [[Comment.nvim]] ] = ""
        pluginList[ [[LuaSnip]] ] = ""
        pluginList[ [[heirline-components.nvim]] ] = ""
        pluginList[ [[accelerated-jk.nvim]] ] = ""
        pluginList[ [[cutlass.nvim]] ] = ""
        pluginList[ [[mini.animate]] ] = ""
        pluginList[ [[mini.hipatterns]] ] = ""
        pluginList[ [[mini.surround]] ] = ""
        pluginList[ [[fold-cycle.nvim]] ] = ""
        pluginList[ [[nvim]] ] = ""
        pluginList[ [[scrollEOF.nvim]] ] = ""
        pluginList[ [[telescope-egrepify.nvim]] ] = ""
        pluginList[ [[tiny-code-action.nvim]] ] = ""
        pluginList[ [[neorg_extras]] ] = ""
        pluginList[ [[yazi.nvim]] ] = ""
        nixLazyPath = allPlugins.start[ [[lazy.nvim]] ]
    end

    local opts = {
        performance = {
            -- Lazy moment
            reset_packpath = false,
        },
        -- Put lazy lock in a more central location
        lockfile = aelius.get_data_path() .. "/lazy-lock.json",
        install = {
            missing = not cat.isNixCats
        }
    }

    self:load_modules_packages()
    lazy.setup(pluginList, nixLazyPath, self.repos, opts)

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
