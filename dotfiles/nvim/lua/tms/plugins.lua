-- ========================================================= --
-- Plugin Configuration
-- ========================================================= --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Theme
    {
        "MartelleV/kaimandres.nvim",
        lazy = false,
        priority = 1000
    },
    -- Features
    "nvim-lualine/lualine.nvim",
    "folke/which-key.nvim",
    "folke/todo-comments.nvim",
    "folke/trouble.nvim",
    "kyazdani42/nvim-web-devicons",
    "kylechui/nvim-surround",
    "norcalli/nvim-colorizer.lua",
    "ziontee113/color-picker.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "sindrets/diffview.nvim",
    "github/copilot.vim",
    "windwp/nvim-ts-autotag",
    "nvim-neotest/nvim-nio",
    "RRethy/vim-illuminate",
    -- AI Tooling
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        }
    },
    -- Autocomplete
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = true } },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    { "nvim-treesitter/nvim-treesitter", branch = "main", lazy = false, build = ":TSUpdate" },
    -- Fuzzy Searching
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
    },
    -- Language Server Config & Plugins
    { "williamboman/mason.nvim",         config = true },
    { "j-hui/fidget.nvim",               opts = {} }
})
