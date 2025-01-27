-- ========================================================= --
-- Autocompletion
-- ========================================================= --

vim.o.completeopt = "menu,menuone,noselect"

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-UP>'] = cmp.mapping.scroll_docs(-4),
        ['<C-DOWN>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    }),
    sources = cmp.config.sources(
        {
            { name = 'nvim_lua' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = 'path' },
            { name = 'buffer' },
        }
    )
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
    })
})

-- ========================================================= --
-- General LSP
-- ========================================================= --

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')

require("mason").setup()

-- Config overrides for specific servers
local lsp_configs = {

    lua_ls = {
        settings = {
            Lua = {
                globals = {
                    "vim",
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false
                },
                telemetry = { enable = false },
            },
        }
    },

    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true
                },
                diagnostics = {
                    enable = true,
                    disabled = { "unresolved-proc-macro" },
                },
            }
        }
    },

    denols = {
        root_dir = nvim_lsp.util.root_pattern("deno.json")
    },

    helm_ls = {
        settings = {
            ['helm-ls'] = {
                yamlls = {
                    enabled = false, -- Currently needs to be disabled or some templates throw a bunch of errors
                    path = "yaml-language-server",
                }
            }
        }
    },

}

-- Define the servers to install
local ensure_installed = {
    "ts_ls",
    "eslint",
    "jsonls",
    "yamlls"
}

-- Add any servers that have config overrides, saves defining them twice
for k in pairs(lsp_configs) do
    ensure_installed[#ensure_installed + 1] = k
end

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup { ensure_installed = ensure_installed }

for _, server in pairs(mason_lspconfig.get_installed_servers()) do
    if server ~= "null-ls" then
        local config = lsp_configs[server] or {}
        nvim_lsp[server].setup {
            capabilities = capabilities,
            settings = config.settings,
            filetypes = config.filetypes,
            root_dir = config.root_dir,
        }
    end
end
