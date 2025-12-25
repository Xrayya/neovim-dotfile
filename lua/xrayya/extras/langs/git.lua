---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "nvim-treesitter"
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ensure_installed = {
        "diff",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
      },
    },
  },
}
