---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "nvim-treesitter"
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ensure_installed = { "java", "javadoc" },
    },
  },
  {
    'nvim-java/nvim-java',
    config = function()
      require('java').setup()
      vim.lsp.enable('jdtls')
    end,
  }
}
