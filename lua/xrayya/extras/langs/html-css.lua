---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "xrayya.essentials.treesitter.treesitter"
    ---@type Xray.treesitterOpts
    opts = {
      ensure_install_parser = { "html", "css", "comment" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = { ensure_installed = { "html", "emmet_ls", "cssls" } },
  },
  {
    "neovim/nvim-lspconfig",
    ---@param opts Xray.lspconfigOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      ---@type vim.lsp.Config
      opts.servers["html"] = {
        filetypes = { "html", "htmlangular" },
      }
      opts.servers["cssls"] = {}
      opts.servers["emmet_ls"] = {}
    end,
  },
}
