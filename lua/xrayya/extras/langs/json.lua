---@module "lazy"
---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "b0o/SchemaStore.nvim",
        version = false,
      },
    },
    ---@module "xrayya.core.modules.lsp"
    ---@param opts Xray.lspconfigOpts
    opts = function(_, opts)
      opts.enable_servers = opts.enable_servers or {}
      opts.enable_servers.jsonls = {
        ---@module "lspconfig"
        ---@type lspconfig.settings.jsonls
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "xrayya.essentials.treesitter.treesitter"
    ---@type Xray.treesitterOpts
    opts = {
      ensure_install_parser = { "json", "json5", "comment" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = { ensure_installed = { "jsonls" } },
  },
}
