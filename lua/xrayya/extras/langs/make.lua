---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "make", "comment" },
        ensure_highlight = { "make", "comment" },
        ensure_fold = { "make" },
      })
    end,
  },
}
