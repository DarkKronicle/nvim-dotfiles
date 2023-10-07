return {
    'ahmedkhalf/project.nvim',
    config = function()
        require('project_nvim').setup({
            patterns = {
                ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "cargo.toml", "pyproject.toml", 'lua', "index.norg"
            },
            ignore_lsp = { 'lua_ls' }
        })

        require('telescope').load_extension('projects')

    end
}
