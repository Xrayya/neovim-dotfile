---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "cmake", "comment" },
        ensure_highlight = { "cmake", "comment" },
        ensure_indent = { "cmake" },
        ensure_fold = { "cmake" },
      })
    end,
  },
}
