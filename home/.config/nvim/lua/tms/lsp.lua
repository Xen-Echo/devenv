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

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- ========================================================= --
-- General LSP
-- ========================================================= --

local nvim_lsp = require('lspconfig')
require("mason").setup()
require("mason-lspconfig").setup()

-- ========================================================= --
-- Rust LSP
-- ========================================================= --

nvim_lsp.rust_analyzer.setup {
    capabilities = capabilities,
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
}

-- ========================================================= --
-- JavaScript / TypeScript LSP
-- ========================================================= --

-- Config is handled with a tsconfig or jsconfig file in the directory

nvim_lsp.tsserver.setup {
    capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern("tsconfig.json")
}

nvim_lsp.eslint.setup {
    capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern("package.json")
}

-- ========================================================= --
-- JSON LSP
-- ========================================================= --

nvim_lsp.jsonls.setup {
    capabilities = capabilities
}

-- ========================================================= --
-- Deno LSP
-- ========================================================= --

nvim_lsp.denols.setup {
    capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern("deno.json")
}
