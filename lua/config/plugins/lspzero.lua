return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    enabled = not vim.g.started_by_firenvim,
    dependencies = {
        -- LSP Support
        { 'folke/neodev.nvim' },
        { 'neovim/nvim-lspconfig' }, -- Required
        {                            -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },                  -- Required
        { 'hrsh7th/cmp-nvim-lsp' },              -- Required
        { 'L3MON4D3/LuaSnip' },                  -- Required
        {'onsails/lspkind.nvim'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-cmdline'},
        {'hrsh7th/cmp-nvim-lsp-signature-help'},
        {'saadparwaiz1/cmp_luasnip'},
        {'rafamadriz/friendly-snippets'},
        {'hrsh7th/cmp-cmdline'},
        {'ray-x/cmp-treesitter'},
        {'chrisgrieser/cmp_yanky'},
    },
    config = function ()
        local lsp = require('lsp-zero')

        lsp.preset({
            configure_diagnostics = true
        })

        lsp.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })

        lsp.setup()

        require('mason').setup()
        require('mason-lspconfig').setup({
            handlers = {
                lsp.default_setup
            }
        })

        local handlers = require('nvim-autopairs.completion.handlers')

        local cmp = require("cmp")
        require('luasnip.loaders.from_vscode').lazy_load()
        local cmp_action = require('lsp-zero').cmp_action()
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done({
                filetypes = {
                    -- "*" is a alias to all filetypes
                    ["*"] = {
                        ["("] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method,
                            },
                            handler = handlers["*"]
                        }
                    },
                    lua = {
                        ["("] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method
                            },
                            ---@param char string
                            ---@param item table item completion
                            ---@param bufnr number buffer number
                            ---@param rules table
                            ---@param commit_character table<string>
                            handler = function(char, item, bufnr, rules, commit_character)
                                -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                            end
                        }
                    },
                    -- Disable for tex
                    tex = false
                }
            })
        )

        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'neorg' },
                { name = 'codeium' },
                { name = 'cmp_yanky' },
                { name = 'treesitter' },
            },
            mapping = {
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item(select_opts)
                    else
                        fallback()
                    end
                end),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item(select_opts)
                    else
                        fallback()
                    end
                end),
                ['<C-J>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.scroll_docs(4)
                    else
                        fallback()
                    end
                end),
                ['<C-K>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.scroll_docs(-4)
                    else
                        fallback()
                    end
                end),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            }, 
            -- window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = cmp.config.window.bordered(),
            -- },
            -- window = {
            --     completion = {
            --         border = border("PmenuBorder"),
            --         winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
            --     },
            --     documentation = {
            --         border = border("CmpDocBorder"),
            --         winhighlight = "Normal:CmpDoc",
            --     },
            -- },

            formatting = {
                fields = { 'abbr', 'kind', 'menu' },
                format = require('lspkind').cmp_format({
                    mode = 'symbol_text',       -- show only symbol annotations
                    maxwidth = 50,         -- prevent the popup from showing more than provided characters
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                })
            }
        })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })



        require 'lspconfig'.matlab_ls.setup({
            root_dir = function()
                return vim.fn.expand('$HOME/Applications/matlab_linux/')
            end
        })

        local lsp_configurations = require('lspconfig.configs')
        local lspconfig = require('lspconfig')
        lsp_configurations.nu_ls = {
            default_config = {
                cmd = { "nu", "--lsp" },
                filetypes = { "nu" },
                root_dir = function(fname)
                    local git_root = lspconfig.util.find_git_ancestor(fname)
                    if git_root then
                        return git_root
                    else
                        return vim.fn.fnamemodify(fname, ":p:h")  -- get the parent directory of the file
                    end
                end
            }
        }
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        lspconfig.nu_ls.setup({ capabilities = capabilities })

        local util = require 'lspconfig.util'

        lspconfig.verible.setup {
            root_dir = util.root_pattern(".svls.toml", ".git", "*.qsf")
        }


        require'lspconfig'.lua_ls.setup {
            on_init = function(client)
                if client.workspace_folders == nil then
                    return true
                end
                local path = client.workspace_folders[1].name
                if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                        Lua = {
                            diagnostics = {
                                globals = {
                                    'vim'
                                }
                            },
                            runtime = {
                                -- Tell the language server which version of Lua you're using
                                -- (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT',
                            },
                            workspace = {
                                checkThirdParty = false,
                            }
                        }
                    })

                    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end
                return true
            end
        }

    end
}
