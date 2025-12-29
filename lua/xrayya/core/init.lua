vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("xrayya.core.options")
require("xrayya.core.keymaps")
require("xrayya.core.plugin-manager")
require("xrayya.core.lsp")
require("xrayya.core.auto")

vim.cmd.colorscheme("tokyonight")
