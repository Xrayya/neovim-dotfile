---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "dockerfile", "comment" },
        ensure_highlight = { "dockerfile", "comment" },
      })
    end,
  },
}
