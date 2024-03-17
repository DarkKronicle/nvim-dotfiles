-- TODO: let this fail gracefully
local lsp_paths = require('core.binaries').lsp

local function attach_capabilities(config)
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local caps = vim.lsp.protocol.make_client_capabilities()
    caps = cmp_nvim_lsp.default_capabilities(caps)
    caps.textDocument.completion.completionItem.snippetSupport = true
    caps.textDocument.foldingRange = { dynamicRegistration = false, rangeLimit = 1000, lineFoldingOnly = true }
    attach_config = {
        capabilities = caps
    }
    attach_config = vim.tbl_deep_extend("force", attach_config, config)
    return attach_config
end

local util = require ('lspconfig.util')

-- Do *NOT* set up rust here, rustaceanvim will do that
local servers = {
    lua_ls = {
        cmd = { lsp_paths.lua_ls },
    },
    texlab = {
        cmd = { lsp_paths.texlab },
    },
    nil_ls = {
        cmd = { lsp_paths.nil_ls },
    },
    svls = {
        cmd = { lsp_paths.svls },
        root_dir = util.root_pattern(
           '.svlsconfig', '.svlsconfig.json', 'svls.toml', 'svls.yaml',
           'svls.yaml', 'svls.yaml', '*.qsf', '.git', '.svls.toml'
        ),
    },
}

local function get_config(name)
    local config = servers[name]
    if not config then
        return
    end
    local t = type(config)
    if t == "boolean" then
        if t then
            config = {}
        else
            return
        end
    end
    if t == "function" then
        config = config()
    end
    return attach_capabilities(config)
end

return function()
    local lsp_config = require('lspconfig')
    for key, _ in pairs(servers) do
        lsp_config[key].setup(get_config(key))
    end
end
