---@module "lazy"
---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          snippets = {
            opts = {
              extended_filetypes = {
                java = { "java-test", "javadoc" },
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "java", "javadoc", "comment" },
        ensure_highlight = { "java", "javadoc", "comment" },
        ensure_indent = { "java", "javadoc" },
        ensure_fold = { "java" },
      })
    end,
  },
  {
    "nvim-java/nvim-java",
    config = function()
      require("java").setup()
      vim.lsp.enable("jdtls")
    end,
  },
}
