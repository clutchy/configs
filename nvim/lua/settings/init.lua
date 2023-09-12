vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.relativenumber = true
vim.o.hlsearch = true
vim.o.undofile = true

vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')

vim.keymap.set('i', '{', '{}<left>')
vim.keymap.set('i', '(', '()<left>')
vim.keymap.set('i', '[', '[]<left>')
vim.keymap.set('n', '<leader>t', vim.cmd.UndotreeToggle)

function surroundWithBrackets(bracket)
  local line = vim.fn.getline(vim.fn.line("."), vim.fn.line("v"))
  vim.fn.append(vim.fn.line("$"), line)
end

vim.keymap.set('v', '<leader>{', function() surroundWithBrackets("{") end)
vim.keymap.set('v', '<leader>(', function() surroundWithBrackets("(") end)
vim.keymap.set('v', '<leader>[', function() surroundWithBrackets("[") end)
