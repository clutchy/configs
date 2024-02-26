vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.scrolloff = 10
vim.o.number = true
vim.o.hlsearch = true
vim.o.undofile = true

vim.opt.termguicolors = true
require('vscode').load()

vim.keymap.set('n', '<leader>t', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<C-h>', vim.cmd.bprevious)
vim.keymap.set('n', '<C-l>', vim.cmd.bnext)
