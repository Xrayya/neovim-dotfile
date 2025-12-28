---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "kitty", "comment" },
        ensure_highlight = { "kitty", "comment" },
      })
    end,
  },
}
