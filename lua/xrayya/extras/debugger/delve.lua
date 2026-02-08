---@module "lazy"
---@type LazySpec
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    ---@module "mason-nvim-dap"
    ---@type MasonNvimDapSettings
    opts = {
      ensure_installed = { "delve" },
    },
  },
  {
    "leoluz/nvim-dap-go",
    opts = {},
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
}
