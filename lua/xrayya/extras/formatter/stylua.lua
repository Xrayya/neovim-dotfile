---@module "lazy"
---@type LazySpec
return {
  {
    "mason-org/mason-lspconfig.nvim",
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = { ensure_installed = { "stylua" } },
  },
  {
    "neovim/nvim-lspconfig",
    ---@param opts Xray.lspconfigOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers["stylua"] = {}
    end,
  },
}
