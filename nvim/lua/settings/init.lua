vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.scrolloff = 10
vim.o.number = true
vim.o.hlsearch = true
vim.o.undofile = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.statuscolumn = "%s %l %r "

vim.opt.termguicolors = true

vim.keymap.set('n', '<leader>t', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<C-h>', vim.cmd.bprevious)
vim.keymap.set('n', '<C-l>', vim.cmd.bnext)

vim.api.nvim_create_user_command('Blame', function()
  local currentLine = vim.fn.line(".")
  local handle = io.popen("git blame -L" .. currentLine .. "," .. currentLine .. " " .. vim.fn.expand("%"))
  local stdout = handle:read("*a")
  handle:close()
  print(stdout)
end, {})
