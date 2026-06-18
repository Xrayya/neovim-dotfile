---@module "lazy"
---@type LazySpec
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "quarto", "codecompanion" },
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
  "nvim-mini/mini.icons",
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "xrayya.essentials.treesitter.treesitter"
    ---@type Xray.treesitterOpts
    opts = {
      ensure_install_parser = { "markdown", "markdown_inline", "html", "latex", "yaml" },
    },
  },
}
