---@module "lazy"
---@type LazySpec
return {
  {
    "stevearc/overseer.nvim",
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {
      dap = false,
    },
  },
}
