---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "javascript", "jsx", "jsdoc", "typescript", "tsx", "comment" },
        ensure_highlight = { "typescript", "html", "typescriptreact", "htmlangular" },
        ensure_indent = { "typescript", "html", "typescriptreact", "htmlangular" },
        ensure_fold = { "typescript", "html", "typescriptreact", "htmlangular" },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed =
        require("xrayya.utils.lsp").check_ensure_installed({ "angularls", "html" }, opts.ensure_installed)
    end,
  },
  {
    {
      "ray-d-song/inlay-hint-trim.nvim",
      opts = {
        clients = {
          ["angularls"] = true,
        },
      },
    },
  },
}
