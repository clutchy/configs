-- require('vscode').load()
-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme tokyonight-night")
require("catppuccin").setup({
  color_overrides = {
    mocha = {
      base = "#000000",
      mantle = "#000000",
      crust = "#000000",
    },
  },
})

vim.cmd("colorscheme catppuccin-mocha")
