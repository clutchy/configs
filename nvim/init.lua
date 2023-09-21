require('plugins')
require('settings')
require('settings.brackets')
require('plugins.filetree')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.lspzero')
require('plugins.prettier')
require('plugins.lspsignature')
require('plugins.comment')

vim.cmd [[
    augroup vim_configuration
    autocmd!
    autocmd BufWritePre *.js Prettier
    autocmd BufWritePre *.ts Prettier
    autocmd BufWritePre *.tsx Prettier
    autocmd BufWritePre *.css Prettier
    autocmd BufWritePre *.html Prettier
    autocmd BufWritePre *.json Prettier
    augroup end
  ]]
