function OpenGitFileHistoryDiff(file, commitBuf, diffBuf)
  local line = vim.fn.getline(".")
  local hash = string.gmatch(line, "%S+")()
  vim.cmd('buffer ' .. diffBuf)
  vim.cmd('%!' .. "git --no-pager diff --no-prefix -U1000 " .. hash .. ".." .. hash .. "~1 -- " .. file)
  vim.cmd('normal dddddddddd')
  vim.cmd('setlocal filetype=diff')
  vim.cmd('buffer ' .. commitBuf)
end

function OpenGitHistoricFile(file, commitBuf, diffBuf, fileType)
  local line = vim.fn.getline(".")
  local hash = string.gmatch(line, "%S+")()
  vim.cmd('buffer ' .. diffBuf)
  vim.cmd('%!' .. "git --no-pager show " .. hash .. ":" .. file)
  vim.cmd('setlocal filetype=' .. fileType)
  vim.cmd('buffer ' .. commitBuf)
end

function OpenCommitDetails(commitBuf, diffBuf)
  local line = vim.fn.getline(".")
  local hash = string.gmatch(line, "%S+")()
  vim.cmd('buffer ' .. diffBuf)
  vim.cmd("%!git --no-pager log " .. hash .. "~1.." .. hash)
  vim.cmd('normal Go')
  vim.cmd('normal Gddpp0DOChanged files:')
  vim.cmd("read !git --no-pager diff --name-only " .. hash .. ".." .. hash .. "~1")
  vim.cmd('buffer ' .. commitBuf)
end

function GitFileHistory()
  local file = vim.fn.expand("%")
  local oldWin = vim.api.nvim_get_current_win()
  local oldBuf = vim.api.nvim_win_get_buf(oldWin)
  local fileType = vim.bo.filetype
  vim.cmd('vsplit')
  vim.cmd('vertical resize 70')
  local win = vim.api.nvim_get_current_win()
  local commitBuf = vim.api.nvim_create_buf(false, false)
  local diffBuf = vim.api.nvim_create_buf(false, false)
  vim.api.nvim_win_set_buf(win, commitBuf)
  vim.api.nvim_win_set_buf(oldWin, diffBuf)

  vim.cmd('buffer ' .. commitBuf)
  vim.cmd('%!' .. "git --no-pager log --pretty=format:'\\%h \\%al (\\%ai) \\%s' -- " .. file)
  local lines = vim.fn.getline(1, "$")
  local hasCommits = lines[1] ~= '' and lines[1] ~= nil

  vim.keymap.set('n', '<CR>', function()
      OpenGitFileHistoryDiff(file, commitBuf, diffBuf)
    end,
    { silent = true, buffer = commitBuf })

  vim.keymap.set('n', 'o', function()
      OpenGitHistoricFile(file, commitBuf, diffBuf, fileType)
    end,
    { silent = true, buffer = commitBuf })

  vim.keymap.set('n', 'd', function()
      OpenCommitDetails(commitBuf, diffBuf)
    end,
    { silent = true, buffer = commitBuf })

  vim.keymap.set('n', 'q', function()
    vim.cmd('buffer ' .. oldBuf)
    vim.cmd('only')
    vim.cmd('bw! ' .. commitBuf)
    vim.cmd('bw! ' .. diffBuf)
  end, {})

  vim.cmd('setlocal nowrap')
  vim.cmd('setlocal cursorline')

  if hasCommits then
    OpenGitFileHistoryDiff(file, commitBuf, diffBuf)
  end
end

vim.keymap.set('n', '<leader>fh', function() GitFileHistory() end, {})
