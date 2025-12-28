---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "ini", "comment" },
        ensure_highlight = { "ini", "comment" },
        ensure_fold = { "ini" },
      })
    end,
  },
}
