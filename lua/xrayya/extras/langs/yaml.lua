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
      opts.enable_servers.yamlls = {
        ---@module "lspconfig"
        ---@type lspconfig.settings.yamlls
        settings = {
          yaml = {
            hover = true,
            completion = true,
            validate = true,
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = require("schemastore").yaml.schemas(),
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
      ensure_install_parser = { "yaml", "comment" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = { ensure_installed = { "yamlls" } },
  },
}
