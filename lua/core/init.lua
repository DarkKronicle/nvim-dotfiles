local disable_distribution_plugins = function()
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_getscript = 1
    vim.g.loaded_getscriptPlugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 0
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_rrhelper = 1
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1
    -- vim.g.loaded_netrwSettings = 1
    -- vim.g.loaded_netrwFileHandlers = 1
    vim.g.matchup_matchparen_enabled = 1
    vim.g.load_black = 1
    vim.g.loaded_node_provider = 1
end


local add_filetypes = function ()
    if not vim.filetype then
        return
    end
end


local set_leader = function ()
    vim.g.mapleader = " "
    vim.g.maplocalleader = ","
end

local use_loader = function () 

    if vim.loader then
        vim.loader.enable()
    end

end

local load_core = function ()
    require("core.globals")

    require("core.pack")
    disable_distribution_plugins()

    use_loader()
    set_leader()
    add_filetypes()

    require("core.options")

    require("core.pack"):boot_strap()

    add_filetypes()
end


load_core()
