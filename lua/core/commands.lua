aelius.command("NvimSource", function ()
    vim.cmd("luafile " .. aelius.get_config_file())
end, {
    force = true,
    nargs = "*",
})
