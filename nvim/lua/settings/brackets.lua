function surroundWithChar(openChar, closeChar)
  local _, startLineNum, startCol, _ = unpack(vim.fn.getcharpos("v"))
  local _, endLineNum, endCol, _ = unpack(vim.fn.getcharpos("."))
  if startLineNum > endLineNum then
    local tmp = startLineNum
    startLineNum = endLineNum
    endLineNum = tmp
    tmp = startCol
    startCol = endCol
    endCol = tmp
  end
  if startLineNum == endLineNum and startCol > endCol then
    local tmp = startCol
    startCol = endCol
    endCol = tmp
  end

  local line = vim.fn.getline(startLineNum, endLineNum)
  local startLine = line[1]
  local endLine = line[#line]

  if vim.fn.mode() == 'V' then
    if #line == 1 then
      vim.fn.setline(startLineNum, openChar .. startLine .. closeChar)
    else
      vim.fn.setline(startLineNum, openChar .. startLine)
      vim.fn.setline(endLineNum, endLine .. closeChar)
    end
    return
  end

  if startLineNum == endLineNum then
    vim.fn.setline(startLineNum, string.sub(startLine, 1, startCol - 1) ..
      openChar ..
      string.sub(startLine, startCol, endCol) ..
      closeChar .. string.sub(startLine, endCol + 1, string.len(startLine)))
  else
    vim.fn.setline(startLineNum, string.sub(startLine, 1, startCol - 1) ..
      openChar .. string.sub(startLine, startCol, string.len(startLine)))
    vim.fn.setline(endLineNum,
      string.sub(endLine, 1, endCol - 1) .. closeChar .. string.sub(endLine, endCol, string.len(endLine)))
  end

  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<ESC>vi", true, false, true) .. closeChar, 't')
end

function skipClosingChar(closeChar)
  local line = vim.fn.getline(vim.fn.line("."))
  local _, lineNum, col, _ = unpack(vim.fn.getcharpos("."))

  if line and string.sub(line, col, col) ~= closeChar then
    vim.fn.setline(lineNum, string.sub(line, 1, col - 1) ..
      closeChar .. string.sub(line, col, string.len(line)))
  end

  vim.fn.setcursorcharpos(lineNum, col + 1)
end

vim.keymap.set('i', '{', '{}<left>')
vim.keymap.set('i', '(', '()<left>')
vim.keymap.set('i', '[', '[]<left>')
vim.keymap.set('i', '}', function() skipClosingChar('}') end)
vim.keymap.set('i', ']', function() skipClosingChar(']') end)
vim.keymap.set('i', ')', function() skipClosingChar(')') end)
vim.keymap.set('i', "'", function() skipClosingChar("'") end)
vim.keymap.set('i', "`", function() skipClosingChar("`") end)
vim.keymap.set('v', '{', function() surroundWithChar("{", "}") end)
vim.keymap.set('v', '(', function() surroundWithChar("(", ")") end)
vim.keymap.set('v', '[', function() surroundWithChar("[", "]") end)
vim.keymap.set('v', '"', function() surroundWithChar('"', '"') end)
vim.keymap.set('v', "'", function() surroundWithChar("'", "'") end)
vim.keymap.set('v', '`', function() surroundWithChar("`", "`") end)
