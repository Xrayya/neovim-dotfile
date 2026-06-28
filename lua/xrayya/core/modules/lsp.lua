---@class Xray.lspconfigOpts
---@field enable_servers table<string, vim.lsp.Config>

---@module "lazy"
---@type LazySpec
return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = {
      automatic_enable = false,
    },
    opts_extend = { "ensure_installed" },
    ---@param opts MasonLspconfigSettings
    config = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed = require("xrayya.utils.lsp").check_ensure_installed(opts.ensure_installed)

      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@param opts Xray.lspconfigOpts
    config = function(_, opts)
      local servers = opts.enable_servers or {}

      for server_name, server_opts in pairs(servers) do
        vim.lsp.config(server_name, server_opts)
        vim.lsp.enable(server_name)
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {},
  },
  {
    "nvimtools/none-ls.nvim",
    config = function(_, opts)
      opts.debug = false

      require("null-ls").setup(opts)
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
