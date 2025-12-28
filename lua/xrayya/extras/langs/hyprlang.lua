---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "hyprlang", "comment" },
        ensure_highlight = { "hyprlang", "comment" },
        ensure_indent = { "hyprlang" },
        ensure_fold = { "hyprlang" },
      })
    end,
  },
}
