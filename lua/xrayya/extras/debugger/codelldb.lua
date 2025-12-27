---@module "lazy"
---@type LazySpec
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    ---@module "mason-nvim-dap"
    ---@type MasonNvimDapSettings
    opts = {
      ensure_installed = { "codelldb" },
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
