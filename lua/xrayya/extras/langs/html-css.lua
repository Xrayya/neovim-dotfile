---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "html", "css", "comment" },
        ensure_highlight = { "html", "css", "comment" },
        ensure_indent = { "html", "css" },
        ensure_fold = { "html", "css" },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed =
          require("xrayya.utils.lsp").check_ensure_installed({ "html", "emmet_ls", "cssls" }, opts.ensure_installed)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers["html"] = {}
      opts.servers["cssls"] = {}
    end,
  },
}
