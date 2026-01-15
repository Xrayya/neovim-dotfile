---@module "lazy"
---@type LazySpec
return {
  {
    "bngarren/checkmate.nvim",
    ft = "markdown",
    opts = {},
    config = function(_, opts)
      require("checkmate").setup(opts)

      local is_ok, whichkey = pcall(require, "which-key")
      if is_ok then
        whichkey.add({ "<Leader>T", group = "Manage Todo(s)" })
      end
    end,
  },
}
