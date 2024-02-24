-- Define extra package paths
-- We need to define `?.lua` and `init.lua`
local add_package_path = function (directory)
    local expanded = vim.fn.expand(directory)
    package.path = package.path .. ';' .. expanded .. '/?.lua'
    package.path = package.path .. ';' .. expanded .. '/?/init.lua'
end

add_package_path('~/.config/nvim_rewrite/lua')
require("core")
