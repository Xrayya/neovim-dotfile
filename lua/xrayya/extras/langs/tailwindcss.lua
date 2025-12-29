---@module "lazy"
---@type LazySpec
return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed =
          require("xrayya.utils.lsp").check_ensure_installed({ "tailwindcss" }, opts.ensure_installed)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@param opts Xray.lspconfigOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers["tailwindcss"] = {}
    end,
  },
}
