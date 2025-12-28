---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "fish", "comment" },
        ensure_highlight = { "fish", "comment" },
        ensure_indent = { "fish" },
        ensure_fold = { "fish" },
      })
    end,
  },
}
