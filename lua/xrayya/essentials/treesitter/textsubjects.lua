---@module "lazy"
---@type LazySpec
return {
  "RRethy/nvim-treesitter-textsubjects",
  opts = {},
  config = function(_, opts)
    require("nvim-treesitter-textsubjects").configure(opts)
  end,
}
