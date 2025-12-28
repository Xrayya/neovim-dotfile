---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "udev", "comment" },
        ensure_highlight = { "udev", "comment" },
      })
    end,
  },
}
