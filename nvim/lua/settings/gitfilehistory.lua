function GetFileHistoryCommits()
  local handle = io.popen("git --no-pager log --follow --pretty=format:'%h %s' -- " .. vim.fn.expand("%"))
  local stdout = handle:read("*a")
  handle:close()
  return stdout
end

function GetFileHistoryDiff(file, hash)
  local handle = io.popen("git diff --no-prefix -U1000 " .. hash .. ".." .. hash .. "~1 -- " .. file)
  local stdout = handle:read("*a")
  handle:close()
  return stdout
end

function OpenGitFileHistory(file, commitBuf, diffBuf, win)
  vim.api.nvim_win_set_buf(win, diffBuf)
  local line = vim.fn.getline(".")
  local hash = string.gmatch(line, "%S+")()
  local diff = GetFileHistoryDiff(file, hash)
  local diffLine = 0
  for s in diff:gmatch("[^\r\n]+") do
    if diffLine < 5 then
      diffLine = diffLine + 1
    else
      vim.fn.appendbufline(diffBuf, diffLine - 5, s)
      diffLine = diffLine + 1
    end
  end

  vim.cmd('buffer ' .. diffBuf)
  vim.cmd('setlocal filetype=diff')
  vim.cmd('buffer ' .. commitBuf)
end

function GitFileHistory()
  local commits = GetFileHistoryCommits()
  local file = vim.fn.expand("%")
  local oldWin = vim.api.nvim_get_current_win()
  local oldBuf = vim.api.nvim_win_get_buf(oldWin)
  vim.cmd('vsplit')
  vim.cmd('vertical resize 70')
  local win = vim.api.nvim_get_current_win()
  local commitBuf = vim.api.nvim_create_buf(false, false)
  local diffBuf = vim.api.nvim_create_buf(false, false)
  vim.api.nvim_win_set_buf(win, commitBuf)
  local fileHistoryLines = 0
  for s in commits:gmatch("[^\r\n]+") do
    fileHistoryLines = fileHistoryLines + 1
    vim.fn.append(vim.fn.line('$') - 1, s)
  end

  vim.keymap.set('n', '<CR>', function()
      vim.api.nvim_buf_set_lines(diffBuf, 0, -1, true, {})
      OpenGitFileHistory(file, commitBuf, diffBuf, oldWin)
    end,
    { silent = true, buffer = commitBuf })

  vim.keymap.set('n', 'q', function()
    vim.cmd('buffer ' .. oldBuf)
    vim.cmd('only')
    vim.cmd('bw! ' .. commitBuf)
    vim.cmd('bw! ' .. diffBuf)
  end, {})

  vim.fn.setcursorcharpos(1, 1)
  vim.fn.deletebufline(commitBuf, vim.fn.line('$'))
  vim.cmd('setlocal nowrap')
  vim.cmd('setlocal cursorline')

  if fileHistoryLines > 0 then
    OpenGitFileHistory(file, commitBuf, diffBuf, oldWin)
  end
end

vim.keymap.set('n', '<leader>fh', function() GitFileHistory() end, {})
