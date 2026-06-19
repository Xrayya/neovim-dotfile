---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "xrayya.essentials.treesitter.treesitter"
    ---@type Xray.treesitterOpts
    opts = {
      ensure_install_parser = { "angular" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = { ensure_installed = { "angularls" } },
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
  {
    "folke/noice.nvim",
    ---@type NoiceConfig
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            find = 'Decoration provider %"win%" %(ns=nvim%.lsp%.inlayhint%):',
          },
          opts = { skip = true }, -- Drop the message completely
        },
        {
          filter = {
            event = "lsp",
            find = "Invalid 'col': out of range",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
