---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "xml", "comment" },
        ensure_highlight = { "xml", "comment" },
        ensure_indent = { "xml" },
        ensure_fold = { "xml" },
      })
    end,
  },
}
