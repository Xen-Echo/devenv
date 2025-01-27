-- ========================================================= --
-- Theme Settings
-- ========================================================= --

require("catppuccin").setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    integrations = {
        cmp = true,
        treesitter = true,
        which_key = true,
        lsp_trouble = true,
        mason = true,
        illuminate = {
            enabled = true,
            lsp = true
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
    }
})

local border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = border
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = border
    }
)

vim.diagnostic.config {
    float = { border = border }
}

require('lspconfig.ui.windows').default_options = {
  border = border
}

vim.cmd.colorscheme "catppuccin"
