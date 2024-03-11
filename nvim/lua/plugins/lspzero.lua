local cmp = require('cmp')
local lsp_zero = require('lsp-zero')
local cmp_action = lsp_zero.cmp_action()

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
  lsp_zero.buffer_autoformat()
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'rust_analyzer', 'cssls', 'cssmodules_ls', 'emmet_language_server',
    'emmet_ls', 'eslint', 'sqlls', 'tsserver' },
  handlers = {
    lsp_zero.default_setup,
  },
})

lsp_zero.setup_servers({ 'tsserver', 'rust_analyzer' })
require("lspconfig").powershell_es.setup({
    bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/"
})

local opts = {
  tools = {
    inlay_hints = {
      auto = true,
      show_parameter_hints = true,
    },
  },
}

require("rust-tools").setup(opts)

local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})

vim.api.nvim_create_user_command('OrganizeImports', function()
  vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
end, {})
