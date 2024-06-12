-- Taken from https://github.com/aohoyd/broot.nvim

local Float = require("core.float")
--@type Config

local Config = {
    broot_conf_path = vim.fn.expand("~/.config/broot/conf.toml"),
    broot_vim_conf_path = vim.fn.expand(vim.fn.stdpath("data") .. "/broot.nvim/conf_nvim.hjson"),
    broot_vim_conf = {
        "verbs: [",
        "  {",
        "    key: enter",
        '    external: "echo +{line} {file}"',
        '    apply_to: "file"',
        "  }",
        "]",
    },

    pass_keys = { "<esc>", "<c-h>", "<c-j>", "<c-k>", "<c-l>" },
}

local M = {}

M.init = function()
    Config.broot_command = string.format("broot --conf '%s;%s'", Config.broot_conf_path, Config.broot_vim_conf_path)
    if vim.fn.filereadable(Config.broot_vim_conf_path) == 1 then
        return
    end

    local parent_dir = vim.fn.fnamemodify(Config.broot_vim_conf_path, ":h")
    if vim.fn.isdirectory(parent_dir) == 0 then
        vim.loop.fs_mkdir(parent_dir, 448)
    end
    vim.fn.writefile(Config.broot_vim_conf, Config.broot_vim_conf_path)
end

local function parse_lines(lines)
    local filtered_files = {}
    for _, line in ipairs(lines) do
        local ln, file = 0, line

        local _, _, ln_match, file_match = string.find(line, "+(%d+)%s+(.*)")
        if ln_match ~= nil and file_match ~= nil then
            ln, file = ln_match, file_match
        end

        if vim.fn.filereadable(file) == 1 then
            table.insert(filtered_files, { file = file, ln = ln })
        end
    end

    if #filtered_files > 0 then
        vim.cmd(string.format("edit +%d %s", filtered_files[1].ln, filtered_files[1].file))
        table.remove(filtered_files, 1)
    end

    for _, file in ipairs(filtered_files) do
        vim.cmd(string.format("%s +%d %s", Config.options.open_split_type, file.ln, file.file))
    end
end

local function remove_file(file)
    if vim.fn.filereadable(file) ~= 0 then
        os.remove(file)
    end
end

-- Opens a floating window
M.open = function(path)
    path = vim.fn.expand(path)
    if vim.fn.isdirectory(path) == 0 then
        path = "."
    end

    local tmp_file = os.tmpname()
    local broot_command =
        string.format("%s %s > %s", Config.broot_command, path, tmp_file)
    local cmd = { "bash", "-c", broot_command }

    local opts = {
        ft = "broot",
        size = { width = 0.8, height = 0.8 },
        border = "none",
    }

    local float = Float.new(opts)

    vim.api.nvim_set_option_value("winhighlight", "Normal:NormalFloat", { scope = "local", win = float.win })

    for _, key in ipairs(Config.pass_keys) do
        vim.keymap.set("t", key, key, { buffer = float.buf, nowait = true })
    end

    local function on_exit(_, e, _)
        if e ~= 0 then
            float:wipe()
            remove_file(tmp_file)
            return
        end

        local lines = {}
        if vim.fn.filereadable(tmp_file) then
            for line in io.lines(tmp_file) do
                table.insert(lines, line)
            end
        end

        parse_lines(lines)

        float:wipe()
        remove_file(tmp_file)
    end

    local terminal = vim.fn.termopen(cmd, { on_exit = on_exit })

    vim.cmd.startinsert()
    vim.api.nvim_create_autocmd("BufEnter", {
        buffer = float.buf,
        callback = function()
            vim.cmd.startinsert()
        end,
    })

    vim.api.nvim_create_autocmd("TermClose", {
        once = true,
        buffer = float.buf,
        callback = function()
            float:close()
            vim.cmd.checktime()
        end,
    })

    return terminal
end

local function create_commands()
    vim.api.nvim_create_user_command("BrootCurrentDir", function()
        M.open("%:p:h")
    end, {})
    vim.api.nvim_create_user_command("BrootWorkingDir", function()
        M.open(".")
    end, {})
    vim.api.nvim_create_user_command("BrootHomeDir", function()
        M.open("~")
    end, {})
end

M.setup = function()
    M.init()

    create_commands()
end

return M
