---@module "lazy"
---@type LazySpec
return {
  "kevintraver/nvim-treesitter-textsubjects",
  branch = "nvim-treesitter-main-migration",
  opts = {},
  config = function(_, opts)
    require("nvim-treesitter-textsubjects").configure(opts)
  end,
}
