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
local mason_lspconfig = require("mason-lspconfig")

require("mason").setup()

local on_attach = function(_, bufnr)
end

local servers = {

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },

  rust_analyzer = {
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
  },

  tsserver = {
    root_dir = nvim_lsp.util.root_pattern("tsconfig.json")
  },

  eslint = {
    root_dir = nvim_lsp.util.root_pattern("package.json")
  },

  denols = {
    root_dir = nvim_lsp.util.root_pattern("deno.json")
  },

  jsonls = {},

  yamlls = {}

}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
      root_dir = (servers[server_name] or {}).root_dir,
    }
  end,
}

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- ========================================================= --
-- Neovim Lua
-- ========================================================= --

require('neodev').setup()

