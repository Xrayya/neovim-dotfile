---@class Xray.lspconfigOpts
---@field servers table<string, vim.lsp.Config>

---@module "lazy"
---@type LazySpec
return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {},
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      local installed_servers = require("mason-lspconfig").get_installed_servers()

      for _, server in pairs(installed_servers) do
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@param opts Xray.lspconfigOpts
    config = function(_, opts)
      local servers = opts.servers or {}
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
