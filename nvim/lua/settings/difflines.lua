LeftContent = {}
RightContent = {}

function DiffSelection()
  local oldWin = vim.api.nvim_get_current_win()
  local oldBuf = vim.api.nvim_win_get_buf(oldWin)
  local fileType = vim.bo.filetype
  vim.cmd('vsplit')
  local win = vim.api.nvim_get_current_win()
  local leftBuf = vim.api.nvim_create_buf(false, false)
  local rightBuf = vim.api.nvim_create_buf(false, false)
  vim.api.nvim_win_set_buf(win, leftBuf)
  vim.api.nvim_win_set_buf(oldWin, rightBuf)
  print(oldWin, win, leftBuf, rightBuf)

  vim.cmd('buffer ' .. leftBuf)
  vim.fn.setbufline(leftBuf, 1, LeftContent)
  vim.cmd('set filetype=' .. fileType)
  vim.keymap.set('n', 'q', function()
    vim.cmd('buffer ' .. oldBuf)
    vim.cmd('only')
    vim.cmd('bw! ' .. leftBuf)
    vim.cmd('bw! ' .. rightBuf)
  end, { silent = true, buffer = leftBuf })

  vim.fn.setbufline(rightBuf, 1, RightContent)
  vim.cmd('buffer ' .. rightBuf)
  vim.cmd('set filetype=' .. fileType)
  vim.keymap.set('n', 'q', function()
    vim.cmd('buffer ' .. oldBuf)
    vim.cmd('only')
    vim.cmd('bw! ' .. leftBuf)
    vim.cmd('bw! ' .. rightBuf)
  end, { silent = true, buffer = rightBuf })
  vim.cmd('buffer ' .. leftBuf)
  vim.cmd('windo diffthis')
end

function LoadSelection(isLeft)
  local startLine = vim.fn.line('.')
  local endLine = vim.fn.line('v')
  if startLine > endLine then
    local tmp = startLine
    startLine = endLine
    endLine = tmp
  end

  local lines = vim.fn.getline(startLine, endLine)
  if isLeft then
    LeftContent = lines
  else
    RightContent = lines
  end
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true))
end

vim.keymap.set('v', '<leader>s', function() LoadSelection(true) end, {})
vim.keymap.set('v', '<leader>d', function()
  LoadSelection()
  DiffSelection()
end, {})
