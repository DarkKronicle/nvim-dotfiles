local api = vim.api
local l = vim.log.levels
local fmt = string.format

aelius.map = vim.keymap.set

--- Call the given function and use `vim.notify` to notify of any errors
--- this function is a wrapper around `xpcall` which allows having a single
--- error handler for all errors
---@param msg string
---@param func function
---@param ... any
---@return boolean, any
---@overload fun(func: function, ...): boolean, any
function aelius.pcall(msg, func, ...)
    local args = { ... }
    if type(msg) == "function" then
        local arg = func --[[@as any]]
        args, func, msg = { arg, unpack(args) }, msg, nil
    end
    return xpcall(func, function(err)
        msg = debug.traceback(msg and fmt("%s:\n%s\n%s", msg, vim.inspect(args), err) or err)
        vim.schedule(function()
            vim.notify(msg, l.ERROR, { title = "ERROR" })
        end)
    end, unpack(args))
end

function aelius.augroup(name, commands)
    name = "aelius_" .. name
    local id = api.nvim_create_augroup(name, { clear = true })
    for _, autocmd in ipairs(commands) do
        local is_callback = type(autocmd.command) == "function"
        api.nvim_create_autocmd(autocmd.event, {
            group = id,
            pattern = autocmd.pattern,
            desc = autocmd.desc,
            callback = is_callback and autocmd.command or nil,
            command = not is_callback and autocmd.command or nil,
            once = autocmd.once or false,
            nested = autocmd.nested,
            buffer = autocmd.buffer,
        })
    end
end

-- https://github.com/vsedov/nvim/blob/fa895996a0150f72c9cf276a20bfaec34dcf4584/lua/core/lambda/helper.lua#L528-L531
function aelius.command(name, rhs, opts)
    opts = opts or {}
    api.nvim_create_user_command(name, rhs, opts)
end


function aelius.ftplugin_conf(configs)
    if type(configs) ~= "table" then
        return
    end
    for name, callback in pairs(configs) do
        local ok, plugin = aelius.pcall(require, name)
        if ok then
            callback(plugin)
        end
    end
end

local function apply_ft_mappings(args, buf)
    vim.iter(args):each(function(m)
        assert(#m == 3, "map args must be a table with at least 3 items")
        local opts = vim.iter(m):fold({ buffer = buf }, function(acc, key, item)
            if type(key) == "string" then
                acc[key] = item
            end
            return acc
        end)
        map(m[1], m[2], m[3], opts)
    end)
end

function aelius.filetype_settings(map)
    local commands = vim.iter(map):map(function(ft, settings)
        local name = type(ft) == "table" and table.concat(ft, ",") or ft
        return {
            pattern = ft,
            event = "FileType",
            desc = ("ft settings for %s"):format(name),
            command = function(args)
                vim.iter(settings):each(function(key, value)
                    if key == "opt" then
                        key = "opt_local"
                    end
                    if key == "mappings" then
                        return apply_ft_mappings(value, args.buf)
                    end
                    if key == "plugins" then
                        return aelius.ftplugin_conf(value)
                    end
                    if type(key) == "function" then
                        return aelius.pcall(key, args)
                    end
                    vim.iter(value):each(function(option, setting)
                        vim[key][option] = setting
                    end)
                end)
            end,
        }
    end)
    aelius.augroup("filetype-settings", { unpack(commands:totable()) })
end

