---@module "lazy"
---@type LazySpec
return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function(_, opts)
      local ensure_installed = require("xrayya.utils.lsp").check_ensure_installed(opts.ensure_installed)

      opts = vim.tbl_deep_extend("force", opts, { ensure_installed })

      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function(_, opts)
      local servers = opts.ensure_setup or {}
      for _, server in pairs(servers) do
        opts = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        }
        vim.lsp.config(server, opts)
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
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
