require('plugins')
require('settings')
require('settings.brackets')
require('settings.gitfilehistory')
require('settings.difflines')
require('plugins.filetree')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.lspzero')
require('plugins.prettier')
require('plugins.lspsignature')
require('plugins.comment')
require('plugins.theme')

vim.cmd('set diffopt+=algorithm:patience,indent-heuristic')

vim.cmd [[
    augroup vim_configuration
    autocmd!
    autocmd BufWritePre *.js Prettier
    autocmd BufWritePre *.ts Prettier
    autocmd BufWritePre *.tsx Prettier
    autocmd BufWritePre *.css Prettier
    autocmd BufWritePre *.html Prettier
    autocmd BufWritePre *.json Prettier
    autocmd BufWritePre *.yaml Prettier
    autocmd BufWritePre *.yml Prettier
    augroup end
  ]]
