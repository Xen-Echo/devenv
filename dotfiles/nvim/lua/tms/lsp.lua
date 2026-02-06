-- ========================================================= --
-- LSP
-- ========================================================= --

-- Config overrides for specific servers
local lsp_configs = {}

lsp_configs["lua-language-server"] = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    -- Standard lua markers or the root neovim config dir
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, "init.lua" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

lsp_configs["rust-analyzer"] = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml" },
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

lsp_configs["gopls"] = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.mod" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}

lsp_configs["templ"] = {
    cmd = { "templ", "lsp" },
    filetypes = { "templ" },
    root_markers = { 'go.work', 'go.mod', '.git' },
}

require("mason").setup()

-- Ensure we have the configured lsp servers installed
local mason_registry = require("mason-registry")
for server, config in pairs(lsp_configs) do
    if not mason_registry.is_installed(server) then
        local pkg = mason_registry.get_package(server)
        pkg:install()
    end
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end
