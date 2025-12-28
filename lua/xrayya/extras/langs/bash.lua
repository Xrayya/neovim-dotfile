---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "bash", "comment" },
        ensure_highlight = { "bash", "comment" },
        ensure_fold = { "bash" },
      })
    end,
  },
}
