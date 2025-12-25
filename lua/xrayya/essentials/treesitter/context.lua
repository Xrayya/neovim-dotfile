---@module "lazy"
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  ---@module "treesitter-context"
  ---@type TSContext.UserConfig
  opts = {
    max_lines = 5,
    line_numbers = true,
    multiline_threshold = 1,
    trim_scope = "outer",
  },
}
