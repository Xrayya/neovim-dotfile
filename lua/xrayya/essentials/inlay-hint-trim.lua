---@module "lazy"
---@type LazySpec
return {
  "ray-d-song/inlay-hint-trim.nvim",
  config = function(_, opts)
    require("inlay-hint-trim").setup(opts)
  end,
}
