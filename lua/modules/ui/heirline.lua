local M = {}

local lib = require('heirline-components.all')

function M.tabline()
    return {
        lib.component.tabline_conditional_padding(),
        lib.component.tabline_buffers({
            close_button = {
                on_click = {
                    callback = function (_, minwid)
                        require('bufdelete').bufdelete(minwid)
                    end
                },
            },
        }),
        lib.component.fill({ hl = { bg = "tabline_bg" } }),
        lib.component.tabline_tabpages(),
    }
end

function M.statuscolumn()
    return { -- UI left column
        init = function(self)
            self.bufnr = vim.api.nvim_get_current_buf()
        end,
        lib.component.foldcolumn(),
        lib.component.fill(),
        lib.component.numbercolumn(),
        lib.component.signcolumn(),
    }
end

function M.statusline()
    return {
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        lib.component.git_branch(),
        lib.component.file_info({ filetype = {}, filename = false, file_modified = false }),
        lib.component.git_diff(),
        lib.component.diagnostics(),
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.fill(),
        lib.component.lsp(),
        lib.component.compiler_state(),
        lib.component.virtual_env(),
        lib.component.nav(),
        lib.component.mode({ surround = { separator = "right" } }),
    }
end

function M.winbar()
    return { -- UI breadcrumbs bar
        init = function(self)
            self.bufnr = vim.api.nvim_get_current_buf()
        end,
        fallthrough = false,
        lib.component.breadcrumbs_when_inactive(),
        lib.component.breadcrumbs({ hl = lib.hl.get_attributes("winbar", true) }),
    }
end

return M
