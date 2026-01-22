---@module "lazy"
---@type LazySpec
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "quarto", "codecompanion" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = {
        lsp = {
          enabled = true,
        },
      },
      render_modes = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "markdown", "markdown_inline", "html", "latex", "yaml" },
        ensure_highlight = { "markdown", "markdown_inline", "html", "latex", "yaml" },
        ensure_indent = { "markdown", "html", "yaml" },
        ensure_fold = { "markdown", "html", "latex", "yaml" },
      })
    end,
  },
}
