local telescope = require('telescope.builtin')

function fileExists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function parentDir(dir)
  return vim.fn.fnamemodify(dir, ':h')
end

local function isGitDir(dir)
  return vim.fn.isdirectory(dir .. '/.git') ~= 0
end

local function getRoot()
  local path = vim.fn.getcwd();

  while path ~= '/' and not isGitDir(path) do
    path = parentDir(path)
  end

  if path == '/' then return nil end
  return path
end

local function getVscodeSearchIgnorePatterns()
  local projectRoot = getRoot()
  local vscodeSettingsPath = projectRoot .. '/.vscode/settings.json'

  if projectRoot == nil then return {} end
  if not fileExists(vscodeSettingsPath) then return {} end
  local f = assert(io.open(vscodeSettingsPath, "rb"))
  local jsonStr = f:read("*all")
  f:close()
  local vscodeSettings = vim.json.decode(jsonStr)

  if vscodeSettings['search.exclude'] == nil then return {} end

  local ignorePatterns = {}
  for k, v in pairs(vscodeSettings['search.exclude']) do
    ignorePatterns[#ignorePatterns + 1] = k
  end

  return ignorePatterns
end

require("telescope").setup {
  defaults = {
    file_ignore_patterns = getVscodeSearchIgnorePatterns()
  }
}

vim.keymap.set('n', '<leader>ff', telescope.git_files, {})
vim.keymap.set('n', '<leader>fa', telescope.find_files, {})
vim.keymap.set('n', '<leader>fl', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fr', telescope.resume, {})
