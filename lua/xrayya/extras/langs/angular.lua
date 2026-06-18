---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "xrayya.essentials.treesitter.treesitter"
    ---@type Xray.treesitterOpts
    opts = {
      ensure_install_parser = { "angular" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed =
        require("xrayya.utils.lsp").check_ensure_installed({ "angularls", "html" }, opts.ensure_installed)
    end,
  },
  {
    {
      "ray-d-song/inlay-hint-trim.nvim",
      opts = {
        clients = {
          ["angularls"] = true,
        },
      },
    },
  },
}
