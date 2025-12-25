---@module "lazy"
return {
  "folke/which-key.nvim",
  dependencies = {
    "nvim-mini/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  config = function()
    local whichkey = require("which-key")
    local icons = require("xrayya.icons")

    whichkey.setup({
      win = {
        border = "rounded",
      },
      layout = {
        align = "center",
      },
    })

    whichkey.add({
      { "gr",        group = "LSP",                    icon = icons.ui.LSP },
      { "gra",       desc = "Code action" },
      { "grI",       desc = "Go to implementation(s)" },
      { "grn",       desc = "Rename" },
      { "grr",       desc = "Go to reference(s)" },
      { "grt",       desc = "Go to type definition(s)" },
      { "<Leader>f", group = "Find" },
    })
  end,
}
