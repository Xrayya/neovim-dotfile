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
    ---@module "xrayya.essentials.treesitter.treesitter"
    ---@type Xray.treesitterOpts
    opts = {
      ensure_install_parser = { "java", "javadoc", "comment" },
    },
  },
  {
    "nvim-java/nvim-java",
    config = function()
      require("java").setup()
      vim.lsp.enable("jdtls")
    end,
  },
}
