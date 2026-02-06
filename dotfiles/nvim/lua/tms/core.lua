-- ========================================================= --
-- Core Settings
-- ========================================================= --

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')
vim.wo.number = true
vim.opt.relativenumber = true
vim.cmd('set splitright')
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.cmd('set termguicolors')
vim.cmd('set noshowmode')
vim.cmd('set noshowcmd')
vim.cmd('set nowrap')
vim.cmd('set clipboard=unnamedplus')
vim.o.completeopt = "menu,menuone,noselect"
vim.o.shell = "nu"
