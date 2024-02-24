local api = vim.api

aelius.map = vim.keymap.set

function aelius.augroup(name, commands)
    name = "aelius_" .. name
    local id = api.nvim_create_augroup(name, { clear = true })
    for _, autocmd in ipairs(commands) do
        local is_callback = type(autocmd.command) == "function"
        api.nvim_create_autocmd(autocmd.event, {
            group = name,
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

