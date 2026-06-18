---@module "lazy"
---@type LazySpec
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },
  {
    "neovim/nvim-lspconfig",
    ---@param opts Xray.lspconfigOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      ---@type vim.lsp.Config
      opts.servers["jsonls"] = {
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
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed = require("xrayya.utils.lsp").check_ensure_installed({ "jsonls" }, opts.ensure_installed)
    end,
  },
}
