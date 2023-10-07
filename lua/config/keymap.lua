M = {}

local legendary = require('legendary')

function M.add_key(desc, mode, map, cmd)
    legendary.keymap({
        map,
        cmd,
        description = desc,
        mode = mode,
    })
end


return M
