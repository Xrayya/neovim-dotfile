---@module "lazy"
---@type LazySpec
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    ---@module "mason-nvim-dap"
    ---@type MasonNvimDapSettings
    opts = {
      ensure_installed = { "firefox" },
    },
  },
}
