-- Inspired by https://github.com/skeletony007/private-mode.nvim/
-- https://vi.stackexchange.com/questions/6177/the-simplest-way-to-start-vim-in-private-mode
local enable_private = function (vim_var, vim_opt)
    vim_var["private_mode"] = true

    vim_opt.history = 0
    vim_opt.backup = false
    vim_opt.modeline = false
    vim_opt.shelltemp = false
    vim_opt.swapfile = false
    vim_opt.undofile = false
    vim_opt.writebackup = false
    vim_opt.secure = true
    vim_opt.viminfo = ""
end

aelius.command("PrivateBuffer", function ()
    enable_private(vim.b, vim.opt_local)
end)

aelius.command("PrivateGlobal", function ()
    enable_private(vim.g, vim.opt)
end)

aelius.augroup("private", {
    {
        event = "BufReadPre",
        command = function ()
            enable_private(vim.b, vim.opt_local)
        end,
        pattern = {
            "secrets.yaml",
            "secrets.json",
            "secrets",
            "/mnt/tomb/*",
            ".env",
        }

    }
})
