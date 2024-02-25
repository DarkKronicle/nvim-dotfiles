local function attach_capabilities(config)
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local caps = vim.lsp.protocol.make_client_capabilities()
    caps = cmp_nvim_lsp.default_capabilities(caps)
    caps.textDocument.completion.completionItem.snippetSupport = true
    attach_config = {
        capabilities = caps
    }
    attach_config = vim.tbl_deep_extend("force", attach_config, config)
    return attach_config
end


local servers = {
    lua_ls = true,
    texlab = true,
}


return function(name)
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
