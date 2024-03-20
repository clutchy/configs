vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'jose-elias-alvarez/null-ls.nvim',
  'MunifTanjim/prettier.nvim',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  'nvim-treesitter/nvim-treesitter',
  'folke/tokyonight.nvim',
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    lazy = true,
    config = false,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    }
  },
  -- Autocompletion
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  'hrsh7th/nvim-cmp',
  'ray-x/lsp_signature.nvim',
  'mbbill/undotree',
  'Mofiqul/vscode.nvim',
  'numToStr/Comment.nvim',
  'mattn/emmet-vim',
  "simrat39/rust-tools.nvim",
  { "rose-pine/neovim", name = "rose-pine" },
})
