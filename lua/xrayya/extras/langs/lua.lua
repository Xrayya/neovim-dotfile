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
                lua = { "luadoc" },
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
      ensure_install_parser = { "lua", "luadoc", "comment" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = { ensure_installed = { "lua_ls" } },
  },
  {
    "neovim/nvim-lspconfig",
    ---@module "xrayya.core.modules.lsp"
    ---@type Xray.lspconfigOpts
    opts = {
      enable_servers = {
        lua_ls = {},
      },
    },
  },
}
