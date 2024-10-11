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
   { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
   -- Features
   "nvim-lualine/lualine.nvim",
   "folke/which-key.nvim",
   "folke/todo-comments.nvim",
   "folke/trouble.nvim",
   "sudormrfbin/cheatsheet.nvim",
   "kyazdani42/nvim-web-devicons",
   "voldikss/vim-floaterm",
   "kylechui/nvim-surround",
   "norcalli/nvim-colorizer.lua",
   "ziontee113/color-picker.nvim",
   "lukas-reineke/indent-blankline.nvim",
   "FraserLee/ScratchPad",
   "sindrets/diffview.nvim",
   "github/copilot.vim",
   "windwp/nvim-ts-autotag",
   "nvim-neotest/nvim-nio",
   { 'kkoomen/vim-doge', build = ":call doge#install()" },
   -- AI Tooling
   {
       "CopilotC-Nvim/CopilotChat.nvim",
       branch = "canary",
       dependencies = {
           { "github/copilot.vim" },
           { "nvim-lua/plenary.nvim" },
       }
   },
   -- Highlighting
   "RRethy/vim-illuminate",
   { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
   "nvim-treesitter/nvim-treesitter-textobjects",
   { "towolf/vim-helm", ft = "helm" },
   -- Autocomplete
   {
      "hrsh7th/nvim-cmp", dependencies = {
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/vim-vsnip",
      },
   },
   -- Fuzzy Searching
   {
      "nvim-telescope/telescope.nvim", dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-telescope/telescope-file-browser.nvim",
      },
   },
   -- Language Server Config & Plugins
   {
      "neovim/nvim-lspconfig", dependencies = {
         { "williamboman/mason.nvim", config = true },
         "williamboman/mason-lspconfig.nvim",
         { "j-hui/fidget.nvim", opts = {} },
         "folke/neodev.nvim",
      },
    },
    -- Dap Config & Plugins
    {
      "mfussenegger/nvim-dap", dependencies = {
         "rcarriga/nvim-dap-ui",
         "jay-babu/mason-nvim-dap.nvim",
         "theHamsta/nvim-dap-virtual-text",
         -- Additional debuggers
      },
    },
})
